#pragma once
#include <QObject>
#include <vector>
#include <math.h>
#include <QtQuick/qsgnode.h>

class FloatBuffer : public QObject
{
	Q_OBJECT

public:
	FloatBuffer(QObject *parent = 0);

	unsigned countPointsBetween(double start, double end) {
		return timeToIndex(end) - timeToIndex(start);
	}

	void toVertexData(double start, double end, QSGGeometry::Point2D *vertices, unsigned n_verticies) {
		unsigned i_min = timeToIndex(start);
		unsigned i_max = timeToIndex(end);

		for (unsigned i=i_min, j=0; i<i_max && j<n_verticies; i++, j++) {
			vertices[j].set(indexToTime(i), m_data[wrapIndex(i)]);
		}
	}

	void setRate(float secondsPerSample) {
		m_secondsPerSample = secondsPerSample;
		dataChanged();
	}

	void allocate(unsigned length) {
		m_data.resize(length);
		if (m_length > length) {
			m_length = length;
			dataChanged();
		}
	}

	float* data() {
		return m_data.data();
	}

	void setValid(unsigned start, unsigned length) {
		m_start = start;
		m_length = length;
		dataChanged();
	}

	void incValid(unsigned length) {
		if (m_length < length) {
			m_length = length;
		}
		dataChanged();
	}

signals:
	void dataChanged();

public slots:
	QObject * getObject() {
		return new FloatBuffer();
	}

private:
	float m_secondsPerSample;
	std::vector<float> m_data;
	size_t m_start;
	size_t m_length;

	unsigned unwrapIndex(unsigned index) {
		if (index >= m_start) {
			return (index - m_start);
		} else {
			return (index + (m_data.size() - m_start));
		}
	}

	unsigned wrapIndex(unsigned index) {
		return (index + m_start) % m_data.size();
	}

	unsigned timeToIndex(double time) {
		if (time < 0) time = 0;
		unsigned t = time / m_secondsPerSample;
		if (t > m_length) return m_length;
		return t;
	}

	double indexToTime(unsigned index) {
		return index * m_secondsPerSample;
	}
};

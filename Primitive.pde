interface Primitive {
	void draw();
}

class Point implements Primitive {
	float x;
    float y;

    Point (float x, float y) {
        this.x = x;
        this.y = y;
    }

    void connect (Point p) {
        line(x, y, p.x, p.y);
    }

    void draw() {
        point(x, y);
    }

    // static void draw (float x, float y) {
    // 	point(x, y);
    // }
}

class Line implements Primitive {
	Point p1;
	Point p2;

	Line (Point p1, Point p2) {
		this.p1 = p1;
		this.p2 = p2;
	}

	void draw() {
		line(p1.x, p1.y, p2.x, p2.y);
	}

	// static void draw (Point p1, Point p2) {
	// 	line(p1.x, p1.y, p2.x, p2.y);
	// }
}

class Circle implements Primitive {
	Point center;
	float radius;

	Circle (Point center, float radius) {
		this.center = center;
		this.radius = radius;
	}

	void draw() {
		ellipse(center.x, center.y, radius, radius);
	}

	// static void draw (Point center, float radius) {
	// 	ellipse(center.x, center.y, radius, radius);
	// }
}

class Rectangle implements Primitive {
	Point topLeft;
	float w;
	float h;

	Rectangle (Point p, float w, float h, boolean center) {
		if (center) {
			this.topLeft = new Point(p.x - w / 2, p.y - h / 2);
			this.w = w;
			this.h = h;
		}
		else {
			this.topLeft = p;
			this.w = w;
			this.h = h;
		}
	}

	Rectangle (Point topLeft, float w, float h) {
		this(topLeft, w, h, false);
	}

	Rectangle (Point topLeft, Point bottomRight) {
		this.topLeft = topLeft;
		this.w = bottomRight.x - topLeft.x;
		this.h = bottomRight.y - topLeft.y;
	}

	void draw() {
		rect(topLeft.x, topLeft.y, w, h);
	}

	Point center() {
		return new Point(topLeft.x + w / 2, topLeft.y + h / 2);
	}
}

class Square extends Rectangle {
	Square (Point topLeft, float length) {
		super(topLeft, length, length);
	}
}
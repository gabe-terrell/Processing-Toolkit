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

    static void draw (float x, float y) {
    	point(x, y);
    }
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

	static void draw (Point p1, Point p2) {
		line(p1.x, p1.y, p2.x, p2.y);
	}
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

	static void draw (Point center, float radius) {
		ellipse(center.x, center.y, radius, radius);
	}
}
public void CGLine(float x1, float y1, float x2, float y2) {
    // TODO HW1
    // You need to implement the "line algorithm" in this section.
    // You can use the function line(x1, y1, x2, y2); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    // For instance: drawPoint(114, 514, color(255, 0, 0)); signifies drawing a red
    // point at (114, 514).
    
    // Bresenham line algorithm
    // Convert coordinates to integer pixel positions
    int x0 = round(x1);
    int y0 = round(y1);
    int x1i = round(x2);
    int y1i = round(y2);

    int dx = abs(x1i - x0);
    int dy = abs(y1i - y0);

    int sx = x0 < x1i ? 1 : -1;
    int sy = y0 < y1i ? 1 : -1;

    int err = dx - dy;

    while (true) {
        drawPoint(x0, y0, color(0));
        if (x0 == x1i && y0 == y1i) break;
        int e2 = 2 * err;
        if (e2 > -dy) {
            err -= dy;
            x0 += sx;
        }

	    if (e2 < dx) {
            err += dx;
            y0 += sy;
        }
	}

    /*
     stroke(0);
     noFill();
     line(x1,y1,x2,y2);
    */
}

// ok, 2025.9.26
public void CGCircle(float centerX, float centerY, float r) {
    // TODO HW1
    // You need to implement the "circle algorithm" in this section.
    // You can use the function circle(x, y, r); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    
    // Initialize coordinates for the midpoint circle algorithm
    float x = r;
    float y = 0;

    // Initial decision parameter
    float P = 1 - r;
    
    // Draw the initial point
    drawCirclePoints(centerX, centerY, x, y);

    while (x > y) {
        y += 1;

        if (P <= 0) {
            P = P + 2 * y + 1;
        } 
        else {
            x -= 1;
            P = P + 2 * y - 2 * x + 1;
        }

        // Draw all 8 symmetric points
        drawCirclePoints(centerX, centerY, x, y);
    }

    /*
    stroke(0);
    noFill();
    circle(x,y,r*2);
    */
}

// Helper function to draw all 8 symmetric points of a circle
private void drawCirclePoints(float centerX, float centerY, float x, float y) {
    // Draw points in all 8 octants using symmetry
    drawPoint(centerX + x, centerY + y, color(0));  // Octant 1
    drawPoint(centerX - x, centerY + y, color(0));  // Octant 2
    drawPoint(centerX + x, centerY - y, color(0));  // Octant 3
    drawPoint(centerX - x, centerY - y, color(0));  // Octant 4
    drawPoint(centerX + y, centerY + x, color(0));  // Octant 5
    drawPoint(centerX - y, centerY + x, color(0));  // Octant 6
    drawPoint(centerX + y, centerY - x, color(0));  // Octant 7
    drawPoint(centerX - y, centerY - x, color(0));  // Octant 8
}
    

public void CGEllipse(float x, float y, float r1, float r2) {
    // TODO HW1
    // You need to implement the "ellipse algorithm" in this section.
    // You can use the function ellipse(x, y, r1,r2); to verify the correct answer.
    // However, remember to comment out the function before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    // Midpoint ellipse algorithm (rasterization)
    // center = (x, y), rx = r1, ry = r2
    float cx = x;
    float cy = y;
    float rx = r1;
    float ry = r2;

    // handle degenerate cases
    if (rx <= 0 && ry <= 0) {
        drawPoint(cx, cy, color(0));
        return;
    }
    if (rx <= 0) {
        // vertical line
        for (float yy = cy - ry; yy <= cy + ry; yy++) drawPoint(cx, round(yy), color(0));
        return;
    }
    if (ry <= 0) {
        // horizontal line
        for (float xx = cx - rx; xx <= cx + rx; xx++) drawPoint(round(xx), cy, color(0));
        return;
    }

    float rx2 = rx * rx;
    float ry2 = ry * ry;

    float xi = 0;
    float yi = ry;

    // decision parameter for region 1
    float p1 = ry2 - (rx2 * ry) + (0.25 * rx2);
    drawEllipsePoints(cx, cy, xi, yi);

    // Region 1
    while ((2 * ry2 * xi) < (2 * rx2 * yi)) {
        xi += 1;
        if (p1 < 0) {
            p1 = p1 + (2 * ry2 * xi) + ry2;
        } else {
            yi -= 1;
            p1 = p1 + (2 * ry2 * xi) - (2 * rx2 * yi) + ry2;
        }
        drawEllipsePoints(cx, cy, xi, yi);
    }

    // Region 2
    float p2 = ry2 * (xi + 0.5) * (xi + 0.5) + rx2 * (yi - 1) * (yi - 1) - rx2 * ry2;
    while (yi > 0) {
        yi -= 1;
        if (p2 > 0) {
            p2 = p2 - (2 * rx2 * yi) + rx2;
        } else {
            xi += 1;
            p2 = p2 + (2 * ry2 * xi) - (2 * rx2 * yi) + rx2;
        }
        drawEllipsePoints(cx, cy, xi, yi);
    }

    /*
    stroke(0);
    noFill();
    ellipse(x,y,r1*2,r2*2);
    */

}

void drawEllipsePoints(float cx, float cy, float x, float y) {
    // Draw points in all 4 quadrants using symmetry
    drawPoint(round(cx + x), round(cy + y), color(0)); // Quadrant 1
    drawPoint(round(cx - x), round(cy + y), color(0)); // Quadrant 2
    drawPoint(round(cx + x), round(cy - y), color(0)); // Quadrant 4
    drawPoint(round(cx - x), round(cy - y), color(0)); // Quadrant 3
}

// Evaluate cubic Bézier at parameter t in [0,1]
private Vector3 evalCubicBezier(Vector3 a, Vector3 b, Vector3 c, Vector3 d, float t) {
    float u = 1 - t;
    float uu = u * u;
    float uuu = uu * u;
    float tt = t * t;
    float ttt = tt * t;

    Vector3 termA = a.mult(uuu); // (1-t)^3 * a
    Vector3 termB = b.mult(3 * uu * t); // 3(1-t)^2 t * b
    Vector3 termC = c.mult(3 * u * tt); // 3(1-t) t^2 * c
    Vector3 termD = d.mult(ttt); // t^3 * d

    return termA.add(termB).add(termC).add(termD);
}

public void CGCurve(Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4) {
    // TODO HW1
    // You need to implement the "bezier curve algorithm" in this section.
    // You can use the function bezier(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x,
    // p4.y); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    
    // Cubic Bézier rasterization by uniform parametric sampling.
    // Estimate sampling density from control polygon length
    float len = distance(p1, p2) + distance(p2, p3) + distance(p3, p4);
    int samples = (int)constrain(floor(len), 32, 400); // clamp sample count

    // draw the start point
    Vector3 start = evalCubicBezier(p1, p2, p3, p4, 0);
    drawPoint(round(start.x), round(start.y), color(0));

    for (int i = 1; i <= samples; i++) {
        float t = i / (float)samples;
        Vector3 pt = evalCubicBezier(p1, p2, p3, p4, t);
        drawPoint(round(pt.x), round(pt.y), color(0));
    }

    /*
    stroke(0);
    noFill();
    bezier(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y,p4.x,p4.y);
    */
}

public void CGEraser(Vector3 p1, Vector3 p2) {
    // TODO HW1
    // You need to erase the scene in the area defined by points p1 and p2 in this
    // section.
    // p1 ------
    // |       |
    // |       |
    // ------ p2
    // The background color is color(250);
    // You can use the mouse wheel to change the eraser range.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    float x1 = min(p1.x, p2.x);
    float x2 = max(p1.x, p2.x);
    float y1 = min(p1.y, p2.y);
    float y2 = max(p1.y, p2.y);
    
    for (float xx = x1; xx <= x2; xx++) {
        for (float yy = y1; yy <= y2; yy++) {
            drawPoint(round(xx), round(yy), color(250));
        }
    }
}

public void drawPoint(float x, float y, color c) {
    stroke(c);
    point(x, y);
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}

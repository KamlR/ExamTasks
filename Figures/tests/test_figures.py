import pytest
import math
from library_files.figures import Circle, Triangle, CircleCreator, TriangleCreator


def test_circle_area():
    circle = Circle(5)
    assert math.isclose(circle.area(), math.pi * 25)


def test_circle_invalid_radius():
    with pytest.raises(ValueError):
        Circle(-1)


def test_triangle_area():
    triangle = Triangle(3, 4, 5)
    assert math.isclose(triangle.area(), 6)


def test_triangle_invalid_sides():
    with pytest.raises(ValueError):
        Triangle(1, 2, 3)


def test_triangle_is_right():
    triangle = Triangle(3, 4, 5)
    assert triangle.is_right_triangle()


def test_triangle_is_not_right():
    triangle = Triangle(2, 2, 3)
    assert not triangle.is_right_triangle()


def test_circle_creator():
    circle = CircleCreator.create_figure(5)
    assert isinstance(circle, Circle)


def test_triangle_creator():
    triangle = TriangleCreator.create_figure(3, 4, 5)
    assert isinstance(triangle, Triangle)

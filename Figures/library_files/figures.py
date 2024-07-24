import abc
import math
class Figure(abc.ABC):
    def area(self):
        raise NotImplementedError("Метод area должен быть переопределён в классе наследнике")

class Circle(Figure):
    def __init__(self, radius):
        if radius <= 0:
            raise ValueError("Радиус должен быть положительным числом")
        self.radius = radius

    def area(self):
        return math.pi * self.radius ** 2


class Triangle(Figure):
    def __init__(self, a, b, c):
        if a <= 0 or b <= 0 or c <= 0:
            raise ValueError("Стороны должны быть положительными числами")
        if a + b <= c or a + c <= b or b + c <= a:
            raise ValueError("Стороны не образуют треугольник")
        self.a = a
        self.b = b
        self.c = c

    def area(self):
        # вычисление полупериметра
        p = (self.a + self.b + self.c) / 2
        return math.sqrt(p * (p - self.a) * (p - self.b) * (p - self.c))

    # Проверка, является ли треугольник прямоугольным по теореме Пифагора
    def is_right_triangle(self):
        sides = sorted([self.a, self.b, self.c])
        return math.isclose(sides[2] ** 2, sides[0] ** 2 + sides[1] ** 2)


class FigureCreator:
    @staticmethod
    def create_figure(*args):
        raise NotImplementedError("Метод create_figure должен быть переопределён в классе наследнике")


class CircleCreator(FigureCreator):
    @staticmethod
    def create_figure(*args):
        return Circle(*args)


class TriangleCreator(FigureCreator):
    @staticmethod
    def create_figure(*args):
        return Triangle(*args)





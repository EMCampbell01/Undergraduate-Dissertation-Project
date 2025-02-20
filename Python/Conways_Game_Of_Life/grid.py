import random


class Grid:
    
    def __init__(self, rows: int, cols: int, data=None):
        self.rows = rows
        self.cols = cols
        self.data = data or [[0 for _ in range(cols)] for _ in range(rows)]

    def __getitem__(self, position):
        row, col = position
        return self.data[row][col]

    def __setitem__(self, position, value):
        row, col = position
        self.data[row][col] = value

    def __str__(self):

        result = ""
        for row in range(self.rows):

            result += "".join("*" if self[row, col] == 1 else " " for col in range(self.cols))

            if row != self.rows - 1:
                result += "\n"

        return result

    @staticmethod
    def random(rows: int, cols: int):
        random.seed()
        data = [[random.randint(0, 1) for _ in range(cols)] for _ in range(rows)]
        return Grid(rows, cols, data)

    def evolve(self):
        next_generation = [[0 for _ in range(self.cols)] for _ in range(self.rows)]

        for row in range(self.rows):

            row_above = (row - 1) % self.rows
            row_below = (row + 1) % self.rows

            for col in range(self.cols):

                col_left = (col - 1) % self.cols
                col_right = (col + 1) % self.cols

                num_neighbors = (
                    self[row_above, col_left]
                    + self[row_above, col]
                    + self[row_above, col_right]
                    + self[row, col_left]
                    + self[row, col_right]
                    + self[row_below, col_left]
                    + self[row_below, col]
                    + self[row_below, col_right]
                )

                if self[row, col] == 1 and (num_neighbors == 2 or num_neighbors == 3):
                    next_generation[row][col] = 1
                elif self[row, col] == 0 and num_neighbors == 3:
                    next_generation[row][col] = 1

        return Grid(self.rows, self.cols, next_generation)

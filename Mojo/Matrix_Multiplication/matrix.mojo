import random

@value
struct Matrix(StringableRaising):

    var rows: Int
    var cols: Int
    var data: List[List[Int]]

    def __getitem__(self, row: Int, col: Int) -> Int:
        return self.data[row][col]

    def __setitem__(mut self, row: Int, col: Int, value: Int) -> None:
        self.data[row][col] = value

    def __str__(self) -> String:
        str = String()

        for row in range(self.rows):
            for col in range(self.cols):
                var element_value = self[row, col]
                var element_string = element_value.__str__()
                str += element_string
                str += " "
            if row != self.rows - 1:
                str += "\n"
        return str

    @staticmethod
    def random(rows: Int, cols: Int) -> Self:

        random.seed()

        data = List[List[Int]]()

        for row in range(rows):

            row_data = List[Int]()

            for col in range(cols):
                row_data.append(int(random.random_si64(0, 999)))
                
            data.append(row_data)

        return Self(rows, cols, data)

    @staticmethod
    def empty(rows: Int, cols: Int) -> Self:

        data = List[List[Int]]()

        for row in range(rows):
            row_data = List[Int]()
            for col in range(cols):
                row_data.append(0)
            data.append(row_data)

        return Self(rows, cols, data)
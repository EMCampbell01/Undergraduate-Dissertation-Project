import pygame
import time
# from grid import Grid
from Conways_Game_Of_Life.grid import Grid


def run_display(
    grid: Grid,
    window_height: int = 600,
    window_width: int = 600,
    background_color: str = "black",
    cell_color: str = "green",
    pause: float = 0.1,
) -> None:

    pygame.init()

    window = pygame.display.set_mode((window_height, window_width))
    pygame.display.set_caption("Conway's Game of Life")

    cell_height = window_height / grid.rows
    cell_width = window_width / grid.cols
    border_size = 1
    cell_fill_color = pygame.Color(cell_color)
    background_fill_color = pygame.Color(background_color)

    generation = 0
    while generation < 10:

        for event in pygame.event.get():
            
            if event.type == pygame.QUIT:
                running = False
                
            elif event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE or event.key == pygame.K_q:
                    running = False


        window.fill(background_fill_color)
        for row in range(grid.rows):
            for col in range(grid.cols):
                if grid[row, col]:
                    x = col * cell_width + border_size
                    y = row * cell_height + border_size
                    width = cell_width - border_size
                    height = cell_height - border_size
                    pygame.draw.rect(window, cell_fill_color, (x, y, width, height))

        pygame.display.flip()
        time.sleep(pause)
        grid = grid.evolve()
        generation += 1

    pygame.quit()


def generate_random_grid(rows: int, cols: int) -> Grid:
    return Grid.random(rows, cols)

def main():
    start = Grid.random(128, 128)
    run_display(start)


if __name__ == "__main__":
    main()

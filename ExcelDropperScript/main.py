import os
import pandas as pd


def save_table(df: pd.DataFrame, save_name: str):
    print("\nНачинаю сохранение файла...")
    df.to_excel(save_name)


def get_input_data():
    print("Введите имя входного файла")
    filename = input()

    while not os.path.isfile(filename) or os.path.splitext(filename)[-1] not in ['.xlsx', '.xls']:
        print("\nТакого файла не существует или это не эксель-таблица.\n"
              "Пожалуйста, введите корректное имя файла\n")

        filename = input()

    cols_to_use = set()

    print("Введите имена столбцов через enter (один столбец -- одна строка)")
    print("Введите -1, чтобы закончить ввод столбцов\n")

    while (col_name := input()) != "-1":
        col_name = col_name.strip()
        cols_to_use.add(col_name)

    print("Введите имя файла для сохранения новой таблицы\n")
    name_to_save = input()

    while not name_to_save:
        print("Нельзя задать пустое имя файла, попробуйте еще раз\n")
        name_to_save = input()

    print("Начинаю чтение файла...")
    df = pd.read_excel(filename, usecols=list(cols_to_use))
    print("Файл прочел\n")

    return df, name_to_save


def main():
    print("Введите 1, чтобы указать имя файла и столбцы")
    print("Введите 2, чтобы выйти\n")

    while True:
        menu_num = input()
        print("\n")

        if menu_num == "2":
            print('Программа остановлена')
            exit()
        
        elif menu_num == "1":
            df, name_to_save = get_input_data()
            save_table(df, name_to_save)
            print(f"файл был сохранен под именем {name_to_save}\n\n")
            print("Введите 1, чтобы указать имя файла и столбцы")
            print("Введите 2, чтобы выйти\n")

        else:
            print("Неизвестный код. Введите 1 или 2\n")


if __name__ == "__main__":
    main()

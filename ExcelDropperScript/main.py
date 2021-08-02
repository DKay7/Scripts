import os
import pandas as pd


def drop_cols_and_save_table(df: pd.DataFrame, column_names: list, save_name: str):
    # df.drop(df.columns.difference(column_names), axis=1, inplace=True)
    df.to_excel(save_name)


def excel_to_csv(filename):
    pass


def get_input_data():
    print("Введите имя входного файла")
    filename = input()

    while not os.path.isfile(filename) or os.path.splitext(filename)[-1] not in ['.xlsx', '.xls']:
        print("\nТакого файла не существует или это не эксель-таблица.\nПожалуйста, введите корректное имя файла\n")
        filename = input()

    cols_to_drop = list()

    print("Введите имена столбцов для удаления через ентер (один столбец -- одна строка)")
    print("Введите -1, чтобы закончить ввод столбцов\n")

    while (col_name := input()) != "-1":
        col_name = col_name.strip()
    
        # if col_name not in list(df):
        #     print("Такого столбца нет, повторите ввод\n")
        #
        # else:
        cols_to_drop.append(col_name)

    cols_to_drop = set(cols_to_drop)

    print("Введите имя файла для сохранения новой таблицы\n")
    name_to_save = input()

    while not name_to_save:
        print("Нельзя задать пустое имя файла, попробуйте еще раз\n")
        name_to_save = input()

    print("Начинаю чтение файла...")
    df = pd.read_excel(filename, usecols=lambda x: x not in cols_to_drop)
    print("Файл прочел\n")

    return df, list(cols_to_drop), name_to_save


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
            df, cols_to_drop, name_to_save = get_input_data()
            print("\nНачал обработку таблицы...\n")
            drop_cols_and_save_table(df, cols_to_drop, name_to_save)
            print(f"файл был сохранен под именем {name_to_save}\n\n")
            print("Введите 1, чтобы указать имя файла и столбцы")
            print("Введите 2, чтобы выйти\n")

        else:
            print("Неизвестный код. Введите 1 или 2\n")


if __name__ == "__main__":
    main()

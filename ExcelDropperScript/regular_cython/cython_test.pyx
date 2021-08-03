# Импортирование библиотек
import os  # библиотека для работы с ОС и файлами
import pandas as pd  # Библиотека для работы с таблицами
from time import time


def save_table(df: pd.DataFrame, save_name: str):
    """
    Функция для сохранения таблицы

    df: Объект DataFrame
    save_name: Имя для сохранения файла
    """
    print("\nНачинаю сохранение файла...")
    df.to_excel(save_name, index=False)


def get_input_data():
    """
    Функция, получающая от пользователя входные данные

    :return: Созданный объект DataFrame, имя для сохранения
    """
    # Получаем от пользователя имя входного файла
    print("Введите имя входного файла")
    filename = input()

    # Проверяем, что такой файл есть и его расширение это ".xlsx" или ".xls"
    # Если оказывается, что файла не существует, заправшиваем имя еще раз, и так до бесконечности
    while not os.path.isfile(filename) or os.path.splitext(filename)[-1] not in ['.xlsx', '.xls']:
        print("\nТакого файла не существует или это не эксель-таблица.\n"
              "Пожалуйста, введите корректное имя файла\n")

        filename = input()

    # Создаем пустое множество, чтобы положить в него имена колонок
    cols_to_use = set()

    # Выводим в консоль инструкции для пользователя
    print("Введите имена столбцов через enter (один столбец -- одна строка)")
    print("Введите -1, чтобы закончить ввод столбцов\n")

    # Пока пользователь не введет -1,
    col_name = input()
    while col_name != "-1":
        # удаляем пробелы по краям введенной им строки
        # т.е. "   имя столбца  " превратится в "имя столбца"
        col_name = col_name.strip()

        # затем записываем имя в множество
        cols_to_use.add(col_name)
        col_name = input()

    # Получаем от пользователя имя файла
    print("Введите имя файла для сохранения новой таблицы\n")
    name_to_save = input()

    # Если вдруг оказалось, что имя -- пустая строка
    # или расширение файла не то, просим пользователя ввести имя еще раз
    while not name_to_save or os.path.splitext(name_to_save)[-1] not in ['.xlsx', '.xls']:
        print("Недопустимое имя файла, попробуйте еще раз\n")
        name_to_save = input()

    # Вспомогательный вывод
    print("Начинаю чтение файла...")

    start1 = time()
    # Создаем объект DataFrame,
    # Читаем наш файл, но не весь, а только те столбцы, что указал пользователь
    df = pd.read_excel(filename, usecols=lambda x: x in cols_to_use)
    # Сообщаем о завершении чтения файла
    print("Файл прочел\n")
    print(f"read: {time() - start1}")
    # Возвращаем объект DataFrame, имя для сохранения в вызывающую функцию
    return df, name_to_save, start1


def main():
    """
    Основная функция, она выполняется при запуске программы
    """

    # Даем пользователю инструкции по работе с меню
    print("Введите 1, чтобы указать имя файла и столбцы")
    print("Введите 2, чтобы выйти\n")

    # Создаем бесконечный цикл
    while True:

        # Принимаем от пользователя номер команды
        menu_num = input()
        print("\n")

        # Если номер -- 2, завершаем программу
        if menu_num == "2":
            print('Программа остановлена')
            exit()

        # Если номер -- 1, ...
        elif menu_num == "1":
            # Получаем объект DataFrame (таблицы) и имя файла
            # из функции для получения данных от пользователя
            df, name_to_save, start1 = get_input_data()

            # Сохраняем таблицу под переданным именем
            start = time()
            save_table(df, name_to_save)
            print(f"Save {time() - start}")
            print(f"Total {time() - start1}")
            # Сообщаем пользователю, что таблица сохранена,
            # возвращаем его в меню
            print(f"файл был сохранен под именем {name_to_save}\n\n")
            print("Введите 1, чтобы указать имя файла и столбцы")
            print("Введите 2, чтобы выйти\n")

        # Если номер ни 1, ни 2,
        # сообщаем пользователю, что мы не знаем, что делать
        else:
            print("Неизвестный код. Введите 1 или 2\n")


# Если файл запускаемый
# (т.е. запускается, а не импортируется в другой файл)
if __name__ == "__main__":
    # Выполняем основную функцию
    main()

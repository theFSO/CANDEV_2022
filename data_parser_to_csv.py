import pandas as pd


def txt_to_csv(filename):
    f = open(filename)
    f_list = f.read().split("\n")
    st = []
    ed = []
    per = []
    num = []
    for i in range(0,len(f_list)):
        temp = []
        if (i%3 == 0):
            st.append(f_list[i])
        elif (i%3 == 1):
            ed.append(f_list[i])
        else:
            foo = f_list[i].split(" ")
            per.append(foo[0] + foo[1])
            num.append(foo[2])
    filename_without_subfix = filename.split(".")[0]
    df = pd.DataFrame({'start_date': st, 'end_data': ed, 'period': per, 'number':num})
    df.to_csv(filename_without_subfix + ".csv", index=False, sep=',')


if __name__ == "__main__":
    txt_to_csv("data/CRSB_by_time.txt")


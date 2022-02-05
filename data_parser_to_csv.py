import pandas as pd
from datetime import datetime

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
            tempdate = datetime.strptime(f_list[i], "%B %d, %Y").strftime("%Y/%m/%d")
            st.append(tempdate)
        elif (i%3 == 1):
            tempdate = datetime.strptime(f_list[i], "%B %d, %Y").strftime("%Y/%m/%d")
            ed.append(tempdate)
        else:
            foo = f_list[i].split(" ")
            per.append(foo[0][1:] + " " + foo[1][:-1])
            num.append(foo[2].replace(",", ""))
    filename_without_subfix = filename[:-4]
    df = pd.DataFrame({'start_date': st, 'end_data': ed, 'period': per, 'number': num})
    df.to_csv(filename_without_subfix + ".csv", index=False, sep=',')


if __name__ == "__main__":
    txt_to_csv("./data/CRSB_by_time.txt")


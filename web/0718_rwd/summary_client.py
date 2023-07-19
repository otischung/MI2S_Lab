import socket
import pickle


def summary_news(text: str, category: str, modifier_level="low", bufsize=4096,
                 HOST="140.116.245.152", PORT=1112,
                 token="eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCJ9.eyJzZXJ2aWNlX2lkIjoiMjciLCJuYmYiOjE2NjAxOTIyMTYsImV4cCI6MTgxNzg3MjIxNiwidmVyIjowLjEsImF1ZCI6IndtbWtzLmNzaWUuZWR1LnR3IiwidXNlcl9pZCI6IjEyMCIsImlzcyI6IkpXVCIsInN1YiI6IiIsInNjb3BlcyI6IjAiLCJpYXQiOjE2NjAxOTIyMTYsImlkIjo0NDN9.R1FXeE7Q2kgg8PzPnAX8r3cWjgWoIvfDwq-2pA6j6Lt8zoKjRrB2e0lmDlzhVhdk4BVUHtzbFm_ObS5cw1ndrhD-qcAT69hxaT3xfeJ7X7UPZvuUaW0kDJiyXP6Zs5sSic1x8T0SvkdHyge9Cv8LAl3EstoYVt22NdHeYzVfJmA") -> str:
    """
    這個函式提供打 MI2S 實驗室有關新聞摘要的 API

    Parameters
    ----------
    text: str
        新聞內文

    category: str
        新聞種類(此五種種類:"社會", "政治", "健康", "經濟", "運動")

    modifier_level: str
        修飾詞抽取程度(此三種種類: "low", "mid", "high")

    bufsize: int
        設定資料傳送的最大值(如果資料太大的話，請謹慎評估網路狀況再至server調整此參數)

    HOST: str
        實驗室摘要伺服器 IP Addr.

    PORT: int
        實驗室摘要伺服器 port

    token: str
        請將API網頁上獲得的token填至此處
    
    Returns
    -------
    out: str
        摘要的文字字串
    """

    news = {
        "body": text,
        "category": category,
        "modifier_level": modifier_level
    }

    input_data = {"token": token, "news": news}
    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client.connect((HOST, PORT))
    client.sendall(pickle.dumps(input_data))
    serverMessage = pickle.loads(client.recv(bufsize))
    # print(serverMessage['summary_ranking'])
    client.close()
    return serverMessage['summary_not_ranking']


def test():
    news = "大聯盟官網今天報導，日籍投手菊池雄星與藍鳥就3年3600萬美元（約台幣10.2億元）的合約達成共識，\
        藍鳥隊的先發輪值更加完整。菊池雄星是從日職轉戰大聯盟，並在2019與水手隊簽下基本3年、最長則為7年的合約，\
        但經過三年後，水手並未執行後續4年6600萬美元合約，菊池因此成為自由球員。菊池雄星在大聯盟累積15勝24敗，防禦率4.97，\
        去年球季是7勝9敗，防禦率4.41，在封館後仍傳出多支球隊對他有興趣，最終菊池雄星選擇加盟藍鳥隊。"
    # "社會", "政治", "健康", "經濟", "運動"
    society_summary = summary_news(news, "運動")
    print(society_summary)
    return


if __name__ == "__main__":
    test()

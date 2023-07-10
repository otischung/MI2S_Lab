from ckip_transformers import __version__
from ckip_transformers.nlp import CkipWordSegmenter, CkipPosTagger, CkipNerChunker
from transformers import BertTokenizerFast, AutoModel
import os


# Pack word segmentation and part-of-speech results
def pack_ws_pos_sentece(sentence_ws, sentence_pos):
    assert len(sentence_ws) == len(sentence_pos)
    res = []
    for word_ws, word_pos in zip(sentence_ws, sentence_pos):
        res.append(f"{word_ws}({word_pos})")
    return "\u3000".join(res)


write_dir = "./Results/"
if not os.path.isdir(write_dir):
    os.mkdir(write_dir)

cnt = 0

# Initialize drivers
print("Initializing drivers ... WS")
ws_driver = CkipWordSegmenter(model="bert-base")
print("Initializing drivers ... POS")
pos_driver = CkipPosTagger(model="bert-base")
print("Initializing drivers ... NER")
ner_driver = CkipNerChunker(model="bert-base")
print("Initializing drivers ... done\n")

# Input text
text = [
    "以色列安全內閣決定，不對本星期發生的汽車炸彈襲擊事件進行報復。以色列把這次爆炸事件歸咎於巴勒斯坦人，但是以色列受於巴拉克總理全權決定如何回應未來的襲擊事件，這個決定是在星期四晚間的內閣會議中做出的。它允許巴拉克自行採取他認為對以色列的安全所必要的任何措施，而無需首先咨詢內閣。在內閣做出這項決議以前，一輛汽車星期三在以色列北部的一個城鎮爆炸，炸死兩名以色列人，至少５０個人受傷。在這同時，巴勒斯坦領導人阿拉法特前往莫斯科，會見俄羅斯總統普京，討論結束８個星期的巴以衝突的途徑。這些衝突已經導致２６０多人喪生，死者多數是巴勒斯坦人。在前去會見俄羅斯官員的前夕，阿拉法特表示仍有希望找出政治解決這場危機的辦法。",
    "美國民主黨總統候選人戈爾的競選班子表示，如果選舉當局宣布他的共和黨選舉對手布什在佛羅里達州獲勝，戈爾不會承認選舉失敗。戈爾的律師表示，他們將在邁阿密戴德縣的選舉結果被確認之後，提出置疑。不久之前，佛羅里達州最高法院駁回了戈爾有關在邁阿密戴德縣繼續進行人工點票的請求。州最高法院這個星期裁決：佛羅里達各縣必須在星期天以前，上報最終選票統計結果。邁阿密戴德縣的選舉官員則表示，他們沒有足夠的時間在最後期限以前完成選票的統計，所以將終止重新點票。戈爾希望人工重新計票能夠獲得足夠的選票，以超過布什的微弱領先的票數。在另外一場法庭訴訟中，戈爾的律師敦促聯邦最高法院駁回共和黨的要求。共和黨要求全部停止佛羅里達州的人工計票。兩位候選人為佛羅里達州的選票爭吵不休，因為他們都需要佛羅里達州的２５張選舉團票才能夠成為總統。",
    "北京一個法院對被取締的“法輪功”組織信徒滕春燕進行了祕密審判。滕春燕的丈夫是美國公民，她本人持有美國綠卡。她被指控犯有間諜罪。“法輪功”發言人和一些沒有透露姓名的外交官說：“滕春燕被控把祕密信息傳遞給外國組織。”設在香港的人權民運信息中心報道：這個中心得到了對滕春燕的定罪書複印件，其中說：“滕春燕把一些外國新聞記者帶到北京郊區一所精神病醫院，這所醫院收留了一些“法輪功”信徒。”滕春燕是在中國受到審判的第一個海外“法輪功”信徒。"
]

# Run pipeline
print("Running pipeline ... WS")
ws = ws_driver(text)
print("Running pipeline ... POS")
pos = pos_driver(ws)
print("Running pipeline ... NER")
ner = ner_driver(text)
print("Running pipeline ... done")
print()

# Show results
for sentence, sentence_ws, sentence_pos, sentence_ner in zip(text, ws, pos, ner):
    # print(sentence)
    print("----- Part Of Speech Tagging -----")
    for i, j in zip(sentence_ws, sentence_pos):
        print(i, j)
    # print(pack_ws_pos_sentece(sentence_ws, sentence_pos))

    print("\n----- Named Entity Recognition -----")
    for entity in sentence_ner:
        print(entity)
    print("\n\n--------------------------------------\n\n")

    with open(write_dir + "ckip_" + str(cnt) + ".txt", "w") as fp:
        fp.write("----- Part Of Speech Tagging -----\n")
        for i, j in zip(sentence_ws, sentence_pos):
            fp.write(str(i) + ' ' + str(j) + '\n')

        fp.write("\n----- Named Entity Recognition -----\n")
        for item in sentence_ner:
            fp.write("%s\n" % str(item))

        # fp.write("\n----- Constituency Parsing -----\n")
        # for item in tree:
        #     fp.write("%s\n" % str(item))

        # fp.write("\n----- Semantic Dependency Parsing -----\n")
        # for item in sdp:
        #     fp.write("%s\n" % str(item))

        # fp.write("\n----- Dependency parsing -----\n")
        # for item in dep:
        #     fp.write("%s\n" % str(item))

        # fp.write("\n----- Semantic Role Labeling -----\n")
        # for item in srl:
        #     fp.write("%s\n" % str(item))

    cnt += 1

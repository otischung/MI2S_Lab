import hanlp

HanLP = hanlp.load(hanlp.pretrained.mtl.CLOSE_TOK_POS_NER_SRL_DEP_SDP_CON_ELECTRA_SMALL_ZH)

total_sentence = "台灣總統蔡英文"
res = HanLP(total_sentence, tasks=["tok/fine", "pos/ctb", "ner/msra", "con", "sdp", "dep", "srl"])

tree = res['con']
all_seg_list = res["tok/fine"]
all_pos_list = res["pos/ctb"]
ner_list = res["ner/msra"]
sdp = res['sdp']
dep = res['dep']
srl = res['srl']


for i, j in zip(all_seg_list, all_pos_list):
    print(i, j)

print(ner_list)
print(tree)
print(sdp)
print(dep)
print(srl)

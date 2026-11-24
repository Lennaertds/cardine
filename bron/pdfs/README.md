# bron/pdfs — waarom deze map niet in git zit

De PDF's hier zijn **ingehaald bronmateriaal** (arXiv-papers, blogposts als PDF).
Samen zijn ze ~166 MB en git kan binaire bestanden niet diffen: elke wijziging
slaat het hele bestand opnieuw op. Daarom staan ze **buiten** de repo.

- **Sync tussen machines:** [Syncthing](https://syncthing.net/) op deze map.
- **In git:** alleen deze README en de `.gitignore`.
- **Terughalen:** de meeste zijn publiek; zie `bronnen-index.md` in `bron/`.

## Bestaande PDF's

| Bestand | Grootte |
|---------|---------|
| `1803.05407v3.pdf` | 720K |
| `AaronJ-Li_TokenEconomizer.pdf` | 608K |
| `Abhimanyu-Das_TimesFM.pdf` | 2.9M |
| `Baoyi-Wang_Better-Call-Grep.pdf` | 6.9M |
| `Chaoqian-Ouyang_TokenCast.pdf` | 1.5M |
| `Daoguang-Zan_SWE-bench-Java.pdf` | 340K |
| `Dawei-Gao_AgentScope-1.0.pdf` | 4.6M |
| `DeepSeek-V3.2.pdf` | 888K |
| `DeepSeek-V3_Technical_Report.pdf` | 1.9M |
| `Dong-Chen_CodeR.pdf` | 1.8M |
| `Dongfang-Zhao_CertEx.pdf` | 4.2M |
| `Dongjian-Ma_LLM-Agents-Can-See-Code-Repositories.pdf` | 13M |
| `EverMind_Raven.pdf` | 3.9M |
| `Hovhannes-Tamoyan_SHERLOC.pdf` | 1.6M |
| `Ibragim-Badertdinov_SWE-rebench.pdf` | 764K |
| `Ishaan-Bhola_Code-Isnt-Memory.pdf` | 376K |
| `Jimenez-Yang_SWE-bench.pdf` | 4.4M |
| `Joel-Niklaus_Dont-Train-the-Model-Evolve-the-Harness.pdf` | 1008K |
| `John-Yang_SWE-bench-Multimodal.pdf` | 4.2M |
| `Junbo-Niu_MinerU2.5.pdf` | 44M |
| `Kang-He_SWE-Adept.pdf` | 1.2M |
| `Kangning-Zhang_Harness-S.pdf` | 1.4M |
| `Lianghong-Guo_SWE-Factory.pdf` | 1.6M |
| `Liang-Zeng_Skywork-SWE.pdf` | 3.3M |
| `Lilin-Wang_SWE-Bench-PlusPlus.pdf` | 4.4M |
| `Linghao-Zhang_SWE-bench-Goes-Live.pdf` | 2.1M |
| `Longju-Bai_How-Do-AI-Agents-Spend-Your-Money.pdf` | 1.3M |
| `Mengyu-Zheng_Claw-SWE-Bench.pdf` | 532K |
| `Mouxiang-Chen_SWE-Universe.pdf` | 1.6M |
| `Naman-Vats_The-Scaffold-Effect-In-Coding-Agents.pdf` | 236K |
| `Prateek-Chhikara_Mem0.pdf` | 1.1M |
| `Preston-Rasmussen_Zep.pdf` | 148K |
| `Priyanshu-Jain_Code-Retrieval-Techniques-In-Coding-Agents.pdf` | 1.1M |
| `Pujun-Zheng_SWE-Bench-Pro-Verified.pdf` | 1.9M |
| `Reem-Aleithan_SWE-Bench-Plus.pdf` | 652K |
| `Revanth-Gangi-Reddy_SweRank.pdf` | 1.7M |
| `Rongxin-Ouyang_PDFMathTranslate.pdf` | 3.6M |
| `Ruiyao-Xu_Harness2.pdf` | 7.8M |
| `Ruofeng-Yang_ARIS.pdf` | 912K |
| `Saurav-Bellam_How-Do-Small-Coding-Agents-Use-Code-Graphs.pdf` | 548K |
| `Shravan-Chaudhari_SpIDER.pdf` | 1.4M |
| `Shuang-Sun_SWE-World.pdf` | 1.4M |
| `Shuo-Yang_FreeToken.pdf` | 868K |
| `Tianyi-Zhou_COLLEAGUE-SKILL.pdf` | 380K |
| `Weili-Cao_Coding-Agents-Are-Effective-Long-Context-Processors.pdf` | 4.7M |
| `Woosuk-Kwon_PagedAttention.pdf` | 1.4M |
| `Wuya-Chen_CodeGrep.pdf` | 1.2M |
| `Xingjian-Bai_ReactiveOptimimzers.pdf` | 636K |
| `Xingyao-Wang_OpenHands.pdf` | 3.2M |
| `Xuchen-Pan_AgentScope-Large-Scale-Simulation.pdf` | 2.7M |
| `Yoonho-Lee_Meta-Harness.pdf` | 1.1M |
| `Youyang-Yin_Unlimited-OCR-Works.pdf` | 496K |
| `Yuling-Shi_SWE-Bench-ProMax.pdf` | 836K |
| `Yunbei-Zhang_Stop-Comparing-LLM-Agents-Without-Disclosing-Harness.pdf` | 580K |
| `Yuru-Wang_NatureBench.pdf` | 7.2M |
| `Zelun-Zhang_PaddleOCR-VL-1.6.pdf` | 1.6M |
| `Zhaoling-Chen_LocAgent.pdf` | 932K |
| `Zhipeng-Xu_SWE-bench-Science.pdf` | 1.2M |
| `Zhonghao-Jiang_Issue-Localization-Code-Graph.pdf` | 1008K |

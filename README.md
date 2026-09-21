# awesome-learning

个人精选的 R 包、Agent Skills、学习网站与 R 书清单，按临床研究与生信的分析工作流组织。
每一条都带一句批注：为什么留下、在哪用过、踩过什么坑。

- 条目：25（软件包 7 · Agent Skills 11 · 书与手册 4 · 站点与清单 3）
- 状态：`在用` 正在项目里用 · `试过` 跑过但没固定进流程 · `待读` 收了还没细看
- Star 数据更新于 2026-09-21

## 目录

- [因果推断](#因果推断)
- [撰写润色](#撰写润色)

## 因果推断

### 软件包

| 名称 | 描述 | 标签 | 状态 | Star | 批注 |
|---|---|---|---|---|---|
| [grf](https://github.com/grf-labs/grf) · [文档](https://grf-labs.github.io/grf/) | 广义随机森林：因果森林、异质处理效应与工具变量森林 | `R` `CRAN` `causal-forest` `HTE` `effect-modifier` | 试过 | 1,111 | 拿它找效应修饰变量时没跑赢 OLS 交互扫描；适合估计 CATE，不适合当变量筛选器。 |
| [DoubleML](https://github.com/DoubleML/doubleml-for-r) · [文档](https://docs.doubleml.org/) | 双重机器学习（Double / Debiased ML）的 R 实现，nuisance 模型走 mlr3 | `R` `CRAN` `DML` `debiased-ML` `mlr3` | 在用 | 171 | causalR 的 dml 敏感性分析（dml.sensemakr）建在它的拟合结果上。 |
| [SuperLearner](https://github.com/ecpolley/SuperLearner) | 超级学习器：多算法加权集成，常作 TMLE、IPW 的 nuisance 估计器 | `R` `CRAN` `ensemble` `nuisance` `TMLE` | 在用 | 294 | causalR::get_PSW 的 super 方案用它估倾向评分，必须显式传 SL.library。 |
| [StratifiedMedicine](https://cran.r-project.org/package=StratifiedMedicine) | 亚组识别与分层医学框架：PRISM 流程串起变量过滤、倾向评分、亚组模型与效应估计 | `R` `CRAN` `subgroup` `HTE` `MOB` `PRISM` | 试过 | 4 | 用 MOB 找效应修饰变量必须传 parm=2，否则预后变量也会被当成分裂点；先做变量过滤反而会多切出假亚组；“没找到亚组”表现为直接报错而不是空结果。 |
| [model4you](https://cran.r-project.org/package=model4you) | 个体化处理效应的模型树与模型森林（pmtree / pmforest），基于 partykit | `R` `CRAN` `model-based-forest` `HTE` `effect-modifier` `partykit` | 试过 |  | pmforest 的变量重要性排效应修饰变量拿过 10/10；varimp 会随机报 contrasts 错，根因是建森林时没限定每个节点两臂的最小样本量。 |
| [causatr](https://github.com/etverse/causatr) · [文档](https://etverse.github.io/causatr/) | 按《Causal Inference: What If》统一封装 g-computation、IPW、AIPW、SNM 与匹配：causat() 拟合，contrast() 对比 | `R` `GitHub` `g-computation` `IPW` `AIPW` `what-if` | 待读 | 5 | 未上 CRAN 的新包，作者注明由 Claude 协助编写；先当 What If 各方法的对照实现看，用之前核一遍数值。 |
| [causalml](https://github.com/uber/causalml) · [文档](https://causalml.readthedocs.io/) | Uber 的 uplift 建模与因果 ML 库：meta-learner、uplift tree、因果森林 | `Python` `PyPI` `uplift` `meta-learner` | 待读 | 6,002 | Python 侧的对照实现，看 meta-learner（S / T / X / R）的接口设计时参考。 |

### 书与手册

| 书名 | 作者 | 形式 | 标签 | 状态 | 批注 |
|---|---|---|---|---|---|
| [Causal Inference in R](https://www.r-causal.org/) | Malcolm Barrett, Lucy D'Agostino McGowan, Travis Gerke | 免费在线 · [源码](https://github.com/r-causal/causal-inference-in-R) | `R` `textbook` `DAG` `propensity-score` `tidyverse` | 在用 | causalR 读书笔记的主线教材之一。 |
| [Causal Inference for Intervention & Service Evaluations](https://nhsengland.github.io/causal-handbook/) | NHS England | 免费在线 · [源码](https://github.com/nhsengland/causal-handbook) | `handbook` `RWD` `policy-evaluation` `quarto` | 待读 | MIT 协议的 Quarto 手册，2026 年初仍标注为初稿；看它怎么给非统计读者讲方法选择。 |
| [Causal Inference for the Brave and True（中文版）](https://github.com/xieliaing/CausalInferenceIntro) | Matheus Facure 原著，xieliaing 中译 | 免费在线 · [源码](https://github.com/xieliaing/CausalInferenceIntro) | `Python` `textbook` `econometrics` `中文` | 待读 | 讲法比统计教材直白，DID、合成控制、RDD 几章可与 R 书互补。 |
| [Applied Propensity Score Analysis with R](https://psa.bryer.org/) | Jason Bryer | 免费在线 · [源码](https://github.com/jbryer/psa) | `R` `propensity-score` `matching` `weighting` `bootstrap` | 待读 | 收的是 bootstrap 一章。延伸阅读：Lee / Lessler / Stuart 2010（PMC2807890）用 ML 改进 PS 加权；Cannas / Arpino 2019（Biometrical Journal）比较 PS 匹配与加权里的 ML 算法和平衡指标。 |

### 站点与清单

| 名称 | 描述 | 标签 | 状态 | 批注 |
|---|---|---|---|---|
| [awesome-causal-inference（libraries）](https://github.com/matteocourthoud/awesome-causal-inference/blob/main/src/libraries.md) | 跨语言因果推断资源清单，libraries 页按语言列出 R、Python、Stata 的因果库 | `awesome-list` `libraries` | 在用 | 找某个方法有没有现成实现时先翻这一页；本仓库不重复它的全量，只收实际用过或准备用的。 |
| [因果推断读书笔记（causalR）](https://hui950319.github.io/causalR/) | 自己的因果推断读书笔记 Quarto 站点，也是 causalR 包（get_sens / plt_sens 敏感性分析）的主页 | `own` `notes` `quarto` `sensitivity-analysis` | 在用 | 本清单里 related 指向 causalR 的条目，都能在这个站点找到对应章节。 |

## 撰写润色

### Agent Skills

| 名称 | 描述 | 标签 | 状态 | Star | 批注 |
|---|---|---|---|---|---|
| [Academic Research Skills（ARS）](https://github.com/Imbad0202/academic-research-skills) | Claude Code 学术写作全流程插件：/ars-plan 苏格拉底式逐章规划、/ars-outline 大纲与证据图、/ars-full 研究→写作→审稿→修改→定稿、/ars-revision-coach 把审稿意见拆成修改路线图与回复信骨架 | `claude-code` `plugin` `pipeline` `CC-BY-NC` | 在用 | 48,920 | 本机以插件方式安装，会话启动即加载。协议 CC BY-NC 4.0，商用受限。书签收的是它的 Codex 移植版 [ARS-Codex](https://github.com/Imbad0202/academic-research-skills-codex)，内容同源，只是打包成单个 Codex skill。 |
| [Scientific Agent Skills](https://github.com/K-Dense-AI/scientific-agent-skills) | K-Dense 的科研 Agent Skills 库：166 个 skill 加 78+ 科学数据库，覆盖生信、基因组、临床研究、药物研发与科学写作，遵循开放的 Agent Skills 标准，也打包成 Agent Plugins | `agent-skills` `bioinformatics` `clinical-research` `MIT` | 待读 | 45,836 | 原名 claude-scientific-skills，改名后不再绑定 Claude，配套论文 arXiv:2609.00065。本机已装的 claude-scientific-writer 插件（scientific-writing / literature-review / peer-review 等写作 skill）是 K-Dense 家的另一个仓库；这个库的重点是数据库与分析类 skill，写作只占一小部分。 |
| [MedSci Skills](https://github.com/Aperivue/medsci-skills) · [文档](https://aperivue.com/skills) | 放射科医生做的临床研究 Agent Skills：59 个 skill 串起选题、检索、研究设计、样本量、统计、图表、写作、报告规范核查、期刊选择、审稿回复，内置 49 种报告指南与偏倚风险工具 | `clinical-research` `reporting-guidelines` `PRISMA` `citation-check` `MIT` | 待读 | 313 | 与临床稿件最贴：把报告指南符合性、引文核验、数值一致性做成投稿前的确定性门禁，这是它和泛用学术 skill 的差别。作者 Yoojin Nam（首尔峨山医院放射科），有 arXiv 论文与 Zenodo DOI；v5.0 新增的模型工程部分（PyTorch / MONAI）对 R 流程用不上。 |
| [Medical Research Agent Skills（AIPOCH）](https://github.com/aipoch/medical-research-skills) · [文档](https://aipoch.com/agent-skills) | AIPOCH 的医学科研 skill 库，550+ 个，按证据洞察、方案设计、数据分析、学术写作四类组织，每个 skill 上线前过 MedSkillAudit 审计 | `medical-research` `bioinformatics` `protocol-design` `MIT` | 待读 | 1,902 | 体量太大不适合整库装，按研究阶段挑：文献与证据发现 79 个，方案设计里有因果推断规划与样本量计算，数据分析里有 R / Python 生信代码生成。仓库自带 skill-auditor，可拿来审自己写的 skill。 |
| [Academic-Search](https://github.com/ustc-ai4science/academic-search) | 中科大 AI4Science 的学术检索 skill：arXiv、Semantic Scholar、OpenAlex、Crossref、Unpaywall、Google Scholar、知网多源检索，按学科路由（医学走 PubMed / Europe PMC / MeSH），去重、引用追踪、BibTeX 导出与开放获取 PDF 下载 | `literature-search` `CNKI` `OpenAlex` `BibTeX` `MIT` | 待读 | 643 | 功能与自己的 lit-to-zotero 高度重叠，差异点是知网支持和只取合法 OA PDF（明确标注 login_required / needs_institution，不绕付费墙）。CDP 浏览器模式会自动拉起独立的 Chrome profile，只用 API 检索则不启动。 |
| [research-skills（luwill）](https://github.com/luwill/research-skills) | 5 个 Claude Code 科研 skill：医学影像 AI 综述写作（narrative / scoping / systematic 路由到 PRISMA、QUADAS、CLAIM、TRIPOD+AI）、lit-search 带召回率度量的时间窗文献检索、research-proposal、scholar-slides 组会 PPT、paper-slide-deck 风格化图片幻灯 | `claude-code` `literature-review` `slides` `medical-imaging` | 待读 | 844 | 仓库没有 LICENSE 文件，复用前要留意。综述 skill 把每条引文的存在、作者、编号、方向核验做成提交前硬门禁，并附可执行审计脚本；lit-search 先建语料、综述 skill 再写，两段分开。 |
| [Research-Paper-Writing-Skills](https://github.com/Master-cai/Research-Paper-Writing-Skills) | 把彭思达公开科研笔记整理成的单个 research-paper-writing skill：Abstract / Introduction / Method / Experiments / Conclusion 分节写作指南与模板、论点与证据对齐检查、审稿人视角自审，支持 Codex、Claude Code、Gemini | `paper-writing` `claude-code` `codex` `MIT` | 待读 | 6,996 | 方法论源头见下面「站点与清单」里的 learning_research。面向 ML / CV / NLP 会议论文的写法（Method、Experiments 分节），投医学期刊的 IMRaD 稿件要自己改节名和论证方式。 |
| [PaperSpine](https://github.com/WUBING2023/PaperSpine) · [文档](https://wubing2023.github.io/PaperSpine/v5/) | 论文全流程 skill（PaperSpine5）：给研究方向、资料或实验数据，它查文献、梳论点、搭大纲、写全文、生成科研配图，再做引用核验、审阅与排版，交付可编辑 Word / LaTeX 与 PDF；材料本地优先，论点与引用要求有证据 | `paper-writing` `local-first` `LaTeX` `Word` `MIT` | 待读 | 5,504 | 收藏时还是 v3 / v4「以动机为导向、修订矩阵、LaTeX 安全审核」的定位，现在是带 Web 工作区的自包含套件（Windows 约 26 MB，v0.4.0 alpha 预发布，未签名），装到 codex 或 claude 宿主。工具链里的 writing_rationale_matrix、citation_support_bank、latex_guard 可以单独看。 |
| [Auto-Empirical Research Skills（AERS）](https://github.com/brycewang-stanford/Auto-Empirical-Research-Skills) · [文档](https://copaper.ai) | 斯坦福 REAP × CoPaper.AI 的社会科学实证研究 skill 库：76 个合集、1,096 个 skill，9 阶段流水线从数据清洗到顶刊投稿，Python / Stata / R + Quarto 三条计量流水线，带数值基准与行为评测 | `econometrics` `DID` `stata` `quarto` `CC-BY-SA` | 待读 | 3,902 | 计量经济学口味：DID、Callaway–Sant'Anna 事件研究、HonestDiD 是它的主场，与因果推断板块里 DID / 合成控制的内容互补。GitHub 显示协议为 Other，实际 LICENSE 是 CC BY-SA 4.0。可通过插件市场只装 empirical-analysis-r 这一条线。 |
| [AI Research SKILLs（Orchestra）](https://github.com/Orchestra-Research/AI-Research-SKILLs) · [文档](http://orchestra-research.com) | Orchestra Research 的 AI 研究工程 skill 库：98 个 skill、23 类，autoresearch 双循环编排从选题、文献到实验与论文写作，其余是 Megatron、vLLM、TRL、微调、RAG、评测等训练与部署知识 | `ML-research` `autoresearch` `paper-writing` `MIT` | 待读 | 12,900 | 面向 ML 研究者，与临床统计关系不大；留它是看 autoresearch 的两层循环怎么把 ideation、ML paper writing 与实验 skill 编排起来。npx 安装器把 skill 装到 ~/.orchestra/skills 再软链到各 agent，Windows 退化为复制。 |
| [GDM Science Skills](https://github.com/google-deepmind/science-skills) · [文档](https://antigravity.google/use-cases/science) | Google DeepMind 的科学 skill 集：约 40 个 skill 对接 AlphaGenome、AlphaFold DB、UniProt、ClinVar、gnomAD、ClinicalTrials.gov、openFDA 等 30+ 数据库，以及 PubMed / Europe PMC / OpenAlex / arXiv / bioRxiv 文献检索 | `genomics` `databases` `literature-search` `Apache-2.0` | 待读 | 3,112 | 本体是 Antigravity 的 Science 插件，也能 npx skills add 装到别的 agent。依赖 uv 管 Python 环境；AlphaGenome、OpenAlex 需要 API key，ClinVar 无 key 也能用只是限速；各数据源有各自的使用条款（SKILL_LICENSES.md）。附技术报告。 |

### 站点与清单

| 名称 | 描述 | 标签 | 状态 | 批注 |
|---|---|---|---|---|
| [learning_research（彭思达科研经验）](https://github.com/pengsida/learning_research) | 浙大彭思达面向实验室新人的科研经验文档：起步、培养科研能力、做 Research Project、论文写作、Rebuttal、学术报告，配 GAMES003 课程 slides 与视频 | `notes` `paper-writing` `rebuttal` `中文` | 待读 | 书签单独收了 Notion 上的[论文写作模板](https://pengsida.notion.site/c1a22465a0fa4b15a12985223916048e)，README 说实验室内部觉得很好用；上面的 Research-Paper-Writing-Skills 就是把这些笔记打包成的 skill。图形 / 视觉方向的会议论文经验，迁移到医学稿要过滤。 |

---

数据源在 [`data/entries.yml`](data/entries.yml)，README 由 [`scripts/build.R`](scripts/build.R) 生成，请勿直接编辑；
Star 由 [`scripts/refresh_stars.R`](scripts/refresh_stars.R) 刷新。协议 [CC0 1.0](LICENSE)。


# awesome-learning

个人精选的 R 包、Agent Skills、视频工具、学习网站与 R 书清单，按临床研究与生信的分析工作流组织。
每一条都带一句批注：为什么留下、在哪用过、踩过什么坑。

- 条目：35（软件包 13 · Agent Skills 13 · 工具 1 · 书与手册 5 · 站点与清单 3）
- 状态：`在用` 正在项目里用 · `试过` 跑过但没固定进流程 · `待读` 收了还没细看
- Star 数据更新于 2026-09-22

## 目录

- [因果推断](#因果推断)
- [视频提取](#视频提取)
- [撰写润色](#撰写润色)

## 因果推断

### 软件包

| 名称 | 描述 | 标签 | 状态 | Star | 批注 |
|---|---|---|---|---|---|
| [grf](https://github.com/grf-labs/grf) · [文档](https://grf-labs.github.io/grf/) | 广义随机森林：因果森林、异质处理效应与工具变量森林 | `R` `CRAN` `causal-forest` `HTE` `effect-modifier` | 试过 | 1,111 | 拿它找效应修饰变量时没跑赢 OLS 交互扫描；适合估计 CATE，不适合当变量筛选器。 |
| [policytree](https://github.com/grf-labs/policytree) · [文档](https://grf-labs.github.io/policytree/) | 用双重稳健得分做策略学习：穷举搜索出全局最优的浅层决策树，给出可解释的分人群治疗分配规则 | `R` `CRAN` `policy-learning` `doubly-robust` `decision-tree` `grf` | 待读 | 89 | grf 的下游：double_robust_scores() 吃 causal_forest / causal_survival_forest / instrumental_forest / multi_arm_causal_forest 的拟合结果，再交给 policy_tree() 学规则，生存结局也能走。它回答的是“谁该用哪种治疗”，不是“哪个变量修饰效应”，和 grf、model4you 那几条的用途不重叠。穷举搜索复杂度 O(p^k n^k (log n + d))，depth=2 就随样本量平方增长；连续协变量先四舍五入或离散化（或用 split.step）能大幅提速，更深的树用 hybrid_policy_tree()。学到的规则必须在留出集上评估，示例本身就是先 train 再 predict。 |
| [fastpolicytree](https://cran.r-project.org/package=fastpolicytree) | policytree 的加速求解器，fastpolicytree() 与 policy_tree() 同接口，返回同一棵最优树但快得多 | `R` `CRAN` `policy-learning` `policy-tree` `performance` `GPL-3` | 待读 |  | 只换求解器：奖励得分还得靠 grf / policytree 的 double_robust_scores() 先算（DESCRIPTION 里 policytree 只是 Suggests，实际配套用）。作者自测 500 例、30 个二值协变量、2 个动作、depth=4：policytree 约 125–138 秒，fastpolicytree 约 0.7–0.9 秒，三个包出的树相同。协议是 GPL (>= 3)，比 policytree 的 MIT 严，写进包或再分发前先确认。CRAN 1.0（2025-06-24），作者 James Cussens（布里斯托），论文 arXiv:2506.15435；源码在 [jcussens/tailoring](https://github.com/jcussens/tailoring) 的 fastpolicytree 子目录（同仓库还有 C 版独立可执行文件），开发版用 devtools::install_github("jcussens/tailoring/fastpolicytree")。 |
| [sparsepolicytree](https://github.com/beniaminogreen/sparsepolicytree) | policytree 的 Rust 多线程穷举搜索实现，sparse_policy_tree() 与 policy_tree() 同接口 | `R` `GitHub` `policy-learning` `policy-tree` `Rust` `multithread` | 待读 | 8 | 名字里的 sparse 指协变量取值稀疏：README 自己写明只有在每个变量取值数较少（约 200 以内）时它才占优，稠密连续变量下 policytree 更快也更完善；fastpolicytree 的对照里它单线程 268 秒、4 线程 100 秒，都慢于 policytree 的 125 秒。编译需要本机装 Rust 工具链（Windows 走 rust 安装向导）；线程数由环境变量 RAYON_NUM_THREADS 控制，在线程池建好前设一次、每个 R 会话都要设。剪枝与 policytree 不完全一致（可能留下未剪的叶子），但预测应当相同。从未上 CRAN，最后一次提交 2023-10；README 里的 install_github("Yale-Medicaid/sparsepolicytree") 现在重定向到 beniaminogreen，GitHub 上挂的 pkgdown 站点已 404。 |
| [DoubleML](https://github.com/DoubleML/doubleml-for-r) · [文档](https://docs.doubleml.org/) | 双重机器学习（Double / Debiased ML）的 R 实现，nuisance 模型走 mlr3 | `R` `CRAN` `DML` `debiased-ML` `mlr3` | 在用 | 170 | causalR 的 dml 敏感性分析（dml.sensemakr）建在它的拟合结果上。 |
| [SuperLearner](https://github.com/ecpolley/SuperLearner) | 超级学习器：多算法加权集成，常作 TMLE、IPW 的 nuisance 估计器 | `R` `CRAN` `ensemble` `nuisance` `TMLE` | 在用 | 294 | causalR::get_PSW 的 super 方案用它估倾向评分，必须显式传 SL.library。 |
| [StratifiedMedicine](https://cran.r-project.org/package=StratifiedMedicine) | 亚组识别与分层医学框架：PRISM 流程串起变量过滤、倾向评分、亚组模型与效应估计 | `R` `CRAN` `subgroup` `HTE` `MOB` `PRISM` | 试过 | 4 | 用 MOB 找效应修饰变量必须传 parm=2，否则预后变量也会被当成分裂点；先做变量过滤反而会多切出假亚组；“没找到亚组”表现为直接报错而不是空结果。 |
| [model4you](https://cran.r-project.org/package=model4you) | 个体化处理效应的模型树与模型森林（pmtree / pmforest），基于 partykit | `R` `CRAN` `model-based-forest` `HTE` `effect-modifier` `partykit` | 试过 |  | pmforest 的变量重要性排效应修饰变量拿过 10/10；varimp 会随机报 contrasts 错，根因是建森林时没限定每个节点两臂的最小样本量。 |
| [causatr](https://github.com/etverse/causatr) · [文档](https://etverse.github.io/causatr/) | 按《Causal Inference: What If》统一封装 g-computation、IPW、AIPW、SNM 与匹配：causat() 拟合，contrast() 对比 | `R` `GitHub` `g-computation` `IPW` `AIPW` `what-if` | 待读 | 5 | 未上 CRAN 的新包，作者注明由 Claude 协助编写；先当 What If 各方法的对照实现看，用之前核一遍数值。 |
| [causalml](https://github.com/uber/causalml) · [文档](https://causalml.readthedocs.io/) | Uber 的 uplift 建模与因果 ML 库：meta-learner、uplift tree、因果森林 | `Python` `PyPI` `uplift` `meta-learner` | 待读 | 6,005 | Python 侧的对照实现，看 meta-learner（S / T / X / R）的接口设计时参考。 |
| [unihtee](https://github.com/insightsengineering/unihtee) · [文档](https://insightsengineering.github.io/unihtee/) | 用 TEM-VIP 在高维数据中筛选治疗效应修饰变量，并提供绝对和相对效应尺度上的推断 | `R` `GitHub` `TEM-VIP` `HTE` `effect-modifier` `causal-ML` | 试过 | 5 | 适合做单变量效应修饰筛选和正式推断；TEM-VIP 是边际线性投影，复杂非线性修饰仍需配合 CATE 或其他方法检查。 |
| [tidyhte](https://github.com/ddimmery/tidyhte) · [文档](https://cran.r-project.org/package=tidyhte) | 以 tidy recipe 语义实现双重稳健的异质处理效应估计，支持交叉拟合、多个结局和多个修饰变量 | `R` `CRAN` `HTE` `doubly-robust` `cross-fitting` `effect-modifier` | 试过 | 16 | 用 basic_config()、add_moderator() 和 estimate_QoI() 串起 HTE 工作流；适合系统比较分类与连续修饰变量，但生存结局需先明确外部估计方案。 |
| [lmtp](https://github.com/nt-williams/lmtp) · [文档](https://www.beyondtheate.com/) | 修正处理策略（MTP）的非参数因果效应估计：干预相对暴露的自然值定义，支持连续、多元暴露与纵向时变混杂 | `R` `CRAN` `MTP` `longitudinal` `TMLE` `SDR` `AGPL-3` | 待读 | 87 | 补的是本节最大的空白：grf / policytree / unihtee / tidyhte / model4you 那批全是单时点，回答“谁该用哪种治疗”；lmtp 回答“所有人的暴露轨迹按某规则移位会怎样”，纵向时变处理这块此前一个包都没有。卖点是把干预定义成相对暴露自然值的移位（如“每人比实际多运动 30 分钟”），连续暴露下不再必然违反正性假设；处理机制统一走密度比分类，绕开连续暴露的密度估计。主力估计量是 TMLE 与 SDR（序贯双重稳健），另有 lmtp_ipw / lmtp_sub 可作对照；暴露支持二值、分类、连续、多元，结局支持二值、连续、生存（含竞争风险）与删失，动态方案、IPSI、聚类数据与调查权重都内置。三个坑：一、它不解决识别问题，序贯可交换性（无不可测时变混杂）照样要，别以为换上 TMLE/SDR 就洗白了混杂；二、shift 函数选得是否科学合理是全部论证的命门，选错了统计再漂亮也没用；三、SuperLearner × 时间点 × 交叉拟合折数，长随访计算量很可观（Imports 里带 future + progressr 就是为这个）。协议 AGPL-3，比 policytree 的 MIT、fastpolicytree 的 GPL-3 都严（多一条网络服务分发条款），封进 causalR 前先查依赖协议兼容性，日常分析自用不受影响。CRAN 1.5.4（2026-05-07），作者 Nicholas Williams + Iván Díaz（Weill Cornell）。没有 pkgdown 站（nt-williams.github.io/lmtp 是 404），学习入口走作者自建的 [Beyond the ATE](https://www.beyondtheate.com/)，Quarto + webR 可在浏览器里直接跑；只想看方法学定位不碰代码的读 arXiv:2304.09460。方法学论文 Díaz, Williams, Hoffman, Schenck (2021, JASA)，软件论文 Williams & Díaz (2023, Observational Studies)。明确不支持中介分析，纵向中介是同组另一个包 [lcmmtp](https://github.com/nt-williams/lcmmtp)。 |

### 书与手册

| 书名 | 作者 | 形式 | 标签 | 状态 | 批注 |
|---|---|---|---|---|---|
| [Causal Inference in R](https://www.r-causal.org/) | Malcolm Barrett, Lucy D'Agostino McGowan, Travis Gerke | 免费在线 · [源码](https://github.com/r-causal/causal-inference-in-R) | `R` `textbook` `DAG` `propensity-score` `tidyverse` | 在用 | causalR 读书笔记的主线教材之一。 |
| [Causal Inference for Intervention & Service Evaluations](https://nhsengland.github.io/causal-handbook/) | NHS England | 免费在线 · [源码](https://github.com/nhsengland/causal-handbook) | `handbook` `RWD` `policy-evaluation` `quarto` | 待读 | MIT 协议的 Quarto 手册，2026 年初仍标注为初稿；看它怎么给非统计读者讲方法选择。 |
| [Causal Inference for the Brave and True（中文版）](https://github.com/xieliaing/CausalInferenceIntro) | Matheus Facure 原著，xieliaing 中译 | 免费在线 · [源码](https://github.com/xieliaing/CausalInferenceIntro) | `Python` `textbook` `econometrics` `中文` | 待读 | 讲法比统计教材直白，DID、合成控制、RDD 几章可与 R 书互补。 |
| [因果推断：献给求真敢为者（Brave and True 另一中译本）](https://ci-book.huangwz.com) | Matheus Facure 原著，黄文喆、许文立（澳门城市大学）中译 | 免费在线 · [源码](https://github.com/Wenzhe-Huang/python-causality-handbook-zh) | `Python` `textbook` `econometrics` `stata` `中文` | 待读 | 与 xieliaing 译本同源不同译：01–25 章加 5 篇扩展章节齐全，卖点是逐章补的 Stata 代码（单独放在 [wenddymacro/stata-causality-handbook-zh](https://github.com/wenddymacro/stata-causality-handbook-zh)）。三套协议分开：Python 代码 MIT、译文 CC BY-NC-SA 4.0（非商业、相同方式共享）、Stata 代码 GPL-3.0，引用转载前先对协议。 |
| [Applied Propensity Score Analysis with R](https://psa.bryer.org/) | Jason Bryer | 免费在线 · [源码](https://github.com/jbryer/psa) | `R` `propensity-score` `matching` `weighting` `bootstrap` | 待读 | 收的是 bootstrap 一章。延伸阅读：Lee / Lessler / Stuart 2010（PMC2807890）用 ML 改进 PS 加权；Cannas / Arpino 2019（Biometrical Journal）比较 PS 匹配与加权里的 ML 算法和平衡指标。 |

### 站点与清单

| 名称 | 描述 | 标签 | 状态 | 批注 |
|---|---|---|---|---|
| [awesome-causal-inference（libraries）](https://github.com/matteocourthoud/awesome-causal-inference/blob/main/src/libraries.md) | 跨语言因果推断资源清单，libraries 页按语言列出 R、Python、Stata 的因果库 | `awesome-list` `libraries` | 在用 | 找某个方法有没有现成实现时先翻这一页；本仓库不重复它的全量，只收实际用过或准备用的。 |
| [因果推断读书笔记（causalR）](https://hui950319.github.io/causalR/) | 自己的因果推断读书笔记 Quarto 站点，也是 causalR 包（get_sens / plt_sens 敏感性分析）的主页 | `own` `notes` `quarto` `sensitivity-analysis` | 在用 | 本清单里 related 指向 causalR 的条目，都能在这个站点找到对应章节。 |

## 视频提取

### Agent Skills

| 名称 | 描述 | 标签 | 状态 | Star | 批注 |
|---|---|---|---|---|---|
| [video-transcribe-turbo（本地 Skill）](https://github.com/openai/whisper) | 基于本地 Whisper turbo 的批量视频 / 音频转写流程，生成 TXT、SRT、JSON，支持 CUDA、断点续跑与输出一致性验证 | `Python` `local-skill` `Whisper` `turbo` `TXT` `SRT` `JSON` `CUDA` | 在用 | 109,467 | 本机已安装 video-transcribe-turbo；默认中文用 turbo / zh，脚本一次加载模型并支持 resume 与 validate。它解决批量转写流程，不等同于逐字人工校对，也不负责画面 OCR。 |
| [bilibili-video-download（归档 Skill）](https://github.com/yutto-dev/yutto) | B 站视频下载工具的归档 Skill，底层使用 yutto，可按需通过 uvx yutto 获取视频文件 | `Python` `Bilibili` `download` `yutto` `uvx` | 待读 | 2,037 | 项目内仅保留归档版 Skill，本机尚未安装 yutto；检测到 uv，可在需要下载 B 站视频时使用 uvx yutto。它只负责下载，不是语音转写工具。 |

### 工具

| 名称 | 描述 | 标签 | 状态 | Star | 批注 |
|---|---|---|---|---|---|
| [mcp-video-analyzer](https://github.com/guimatheus92/mcp-video-analyzer) | 已注册的 MCP 视频分析服务：语音转写、关键帧提取、OCR、视频元数据与时间线分析，支持本地视频及 YouTube / Bilibili 链接 | `Python` `MCP` `video` `ASR` `OCR` `Whisper` `FFmpeg` | 在用 | 72 | 本机已安装并注册 0.10.1，CUDA 使用 RTX 5090 Laptop GPU；调用 get_transcript 时显式传 model=turbo，长视频和批量任务转用 video-transcribe-turbo，避免把默认 small 当成 turbo。 |

## 撰写润色

### Agent Skills

| 名称 | 描述 | 标签 | 状态 | Star | 批注 |
|---|---|---|---|---|---|
| [Academic Research Skills（ARS）](https://github.com/Imbad0202/academic-research-skills) | Claude Code 学术写作全流程插件：/ars-plan 苏格拉底式逐章规划、/ars-outline 大纲与证据图、/ars-full 研究→写作→审稿→修改→定稿、/ars-revision-coach 把审稿意见拆成修改路线图与回复信骨架 | `claude-code` `plugin` `pipeline` `CC-BY-NC` | 在用 | 49,107 | 本机以插件方式安装，会话启动即加载。协议 CC BY-NC 4.0，商用受限。书签收的是它的 Codex 移植版 [ARS-Codex](https://github.com/Imbad0202/academic-research-skills-codex)，内容同源，只是打包成单个 Codex skill。 |
| [Scientific Agent Skills](https://github.com/K-Dense-AI/scientific-agent-skills) | K-Dense 的科研 Agent Skills 库：166 个 skill 加 78+ 科学数据库，覆盖生信、基因组、临床研究、药物研发与科学写作，遵循开放的 Agent Skills 标准，也打包成 Agent Plugins | `agent-skills` `bioinformatics` `clinical-research` `MIT` | 待读 | 46,046 | 原名 claude-scientific-skills，改名后不再绑定 Claude，配套论文 arXiv:2609.00065。本机已装的 claude-scientific-writer 插件（scientific-writing / literature-review / peer-review 等写作 skill）是 K-Dense 家的另一个仓库；这个库的重点是数据库与分析类 skill，写作只占一小部分。 |
| [MedSci Skills](https://github.com/Aperivue/medsci-skills) · [文档](https://aperivue.com/skills) | 放射科医生做的临床研究 Agent Skills：59 个 skill 串起选题、检索、研究设计、样本量、统计、图表、写作、报告规范核查、期刊选择、审稿回复，内置 49 种报告指南与偏倚风险工具 | `clinical-research` `reporting-guidelines` `PRISMA` `citation-check` `MIT` | 待读 | 313 | 与临床稿件最贴：把报告指南符合性、引文核验、数值一致性做成投稿前的确定性门禁，这是它和泛用学术 skill 的差别。作者 Yoojin Nam（首尔峨山医院放射科），有 arXiv 论文与 Zenodo DOI；v5.0 新增的模型工程部分（PyTorch / MONAI）对 R 流程用不上。 |
| [Medical Research Agent Skills（AIPOCH）](https://github.com/aipoch/medical-research-skills) · [文档](https://aipoch.com/agent-skills) | AIPOCH 的医学科研 skill 库，550+ 个，按证据洞察、方案设计、数据分析、学术写作四类组织，每个 skill 上线前过 MedSkillAudit 审计 | `medical-research` `bioinformatics` `protocol-design` `MIT` | 待读 | 1,905 | 体量太大不适合整库装，按研究阶段挑：文献与证据发现 79 个，方案设计里有因果推断规划与样本量计算，数据分析里有 R / Python 生信代码生成。仓库自带 skill-auditor，可拿来审自己写的 skill。 |
| [Academic-Search](https://github.com/ustc-ai4science/academic-search) | 中科大 AI4Science 的学术检索 skill：arXiv、Semantic Scholar、OpenAlex、Crossref、Unpaywall、Google Scholar、知网多源检索，按学科路由（医学走 PubMed / Europe PMC / MeSH），去重、引用追踪、BibTeX 导出与开放获取 PDF 下载 | `literature-search` `CNKI` `OpenAlex` `BibTeX` `MIT` | 待读 | 646 | 功能与自己的 lit-to-zotero 高度重叠，差异点是知网支持和只取合法 OA PDF（明确标注 login_required / needs_institution，不绕付费墙）。CDP 浏览器模式会自动拉起独立的 Chrome profile，只用 API 检索则不启动。 |
| [research-skills（luwill）](https://github.com/luwill/research-skills) | 5 个 Claude Code 科研 skill：医学影像 AI 综述写作（narrative / scoping / systematic 路由到 PRISMA、QUADAS、CLAIM、TRIPOD+AI）、lit-search 带召回率度量的时间窗文献检索、research-proposal、scholar-slides 组会 PPT、paper-slide-deck 风格化图片幻灯 | `claude-code` `literature-review` `slides` `medical-imaging` | 待读 | 844 | 仓库没有 LICENSE 文件，复用前要留意。综述 skill 把每条引文的存在、作者、编号、方向核验做成提交前硬门禁，并附可执行审计脚本；lit-search 先建语料、综述 skill 再写，两段分开。 |
| [Research-Paper-Writing-Skills](https://github.com/Master-cai/Research-Paper-Writing-Skills) | 把彭思达公开科研笔记整理成的单个 research-paper-writing skill：Abstract / Introduction / Method / Experiments / Conclusion 分节写作指南与模板、论点与证据对齐检查、审稿人视角自审，支持 Codex、Claude Code、Gemini | `paper-writing` `claude-code` `codex` `MIT` | 待读 | 7,032 | 方法论源头见下面「站点与清单」里的 learning_research。面向 ML / CV / NLP 会议论文的写法（Method、Experiments 分节），投医学期刊的 IMRaD 稿件要自己改节名和论证方式。 |
| [PaperSpine](https://github.com/WUBING2023/PaperSpine) · [文档](https://wubing2023.github.io/PaperSpine/v5/) | 论文全流程 skill（PaperSpine5）：给研究方向、资料或实验数据，它查文献、梳论点、搭大纲、写全文、生成科研配图，再做引用核验、审阅与排版，交付可编辑 Word / LaTeX 与 PDF；材料本地优先，论点与引用要求有证据 | `paper-writing` `local-first` `LaTeX` `Word` `MIT` | 待读 | 5,556 | 收藏时还是 v3 / v4「以动机为导向、修订矩阵、LaTeX 安全审核」的定位，现在是带 Web 工作区的自包含套件（Windows 约 26 MB，v0.4.0 alpha 预发布，未签名），装到 codex 或 claude 宿主。工具链里的 writing_rationale_matrix、citation_support_bank、latex_guard 可以单独看。 |
| [Auto-Empirical Research Skills（AERS）](https://github.com/brycewang-stanford/Auto-Empirical-Research-Skills) · [文档](https://copaper.ai) | 斯坦福 REAP × CoPaper.AI 的社会科学实证研究 skill 库：76 个合集、1,096 个 skill，9 阶段流水线从数据清洗到顶刊投稿，Python / Stata / R + Quarto 三条计量流水线，带数值基准与行为评测 | `econometrics` `DID` `stata` `quarto` `CC-BY-SA` | 待读 | 4,116 | 计量经济学口味：DID、Callaway–Sant'Anna 事件研究、HonestDiD 是它的主场，与因果推断板块里 DID / 合成控制的内容互补。GitHub 显示协议为 Other，实际 LICENSE 是 CC BY-SA 4.0。可通过插件市场只装 empirical-analysis-r 这一条线。 |
| [AI Research SKILLs（Orchestra）](https://github.com/Orchestra-Research/AI-Research-SKILLs) · [文档](http://orchestra-research.com) | Orchestra Research 的 AI 研究工程 skill 库：98 个 skill、23 类，autoresearch 双循环编排从选题、文献到实验与论文写作，其余是 Megatron、vLLM、TRL、微调、RAG、评测等训练与部署知识 | `ML-research` `autoresearch` `paper-writing` `MIT` | 待读 | 12,940 | 面向 ML 研究者，与临床统计关系不大；留它是看 autoresearch 的两层循环怎么把 ideation、ML paper writing 与实验 skill 编排起来。npx 安装器把 skill 装到 ~/.orchestra/skills 再软链到各 agent，Windows 退化为复制。 |
| [GDM Science Skills](https://github.com/google-deepmind/science-skills) · [文档](https://antigravity.google/use-cases/science) | Google DeepMind 的科学 skill 集：约 40 个 skill 对接 AlphaGenome、AlphaFold DB、UniProt、ClinVar、gnomAD、ClinicalTrials.gov、openFDA 等 30+ 数据库，以及 PubMed / Europe PMC / OpenAlex / arXiv / bioRxiv 文献检索 | `genomics` `databases` `literature-search` `Apache-2.0` | 待读 | 3,121 | 本体是 Antigravity 的 Science 插件，也能 npx skills add 装到别的 agent。依赖 uv 管 Python 环境；AlphaGenome、OpenAlex 需要 API key，ClinVar 无 key 也能用只是限速；各数据源有各自的使用条款（SKILL_LICENSES.md）。附技术报告。 |

### 站点与清单

| 名称 | 描述 | 标签 | 状态 | 批注 |
|---|---|---|---|---|
| [learning_research（彭思达科研经验）](https://github.com/pengsida/learning_research) | 浙大彭思达面向实验室新人的科研经验文档：起步、培养科研能力、做 Research Project、论文写作、Rebuttal、学术报告，配 GAMES003 课程 slides 与视频 | `notes` `paper-writing` `rebuttal` `中文` | 待读 | 书签单独收了 Notion 上的[论文写作模板](https://pengsida.notion.site/c1a22465a0fa4b15a12985223916048e)，README 说实验室内部觉得很好用；上面的 Research-Paper-Writing-Skills 就是把这些笔记打包成的 skill。图形 / 视觉方向的会议论文经验，迁移到医学稿要过滤。 |

---

数据源在 [`data/entries.yml`](data/entries.yml)，README 由 [`scripts/build.R`](scripts/build.R) 生成，请勿直接编辑；
Star 由 [`scripts/refresh_stars.R`](scripts/refresh_stars.R) 刷新。协议 [CC0 1.0](LICENSE)。


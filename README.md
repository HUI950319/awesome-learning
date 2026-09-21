# awesome-learning

个人精选的 R 包、学习网站与 R 书清单，按临床研究与生信的分析工作流组织。
每一条都带一句批注：为什么留下、在哪用过、踩过什么坑。

- 条目：13（软件包 7 · 书与手册 4 · 站点与清单 2）
- 状态：`在用` 正在项目里用 · `试过` 跑过但没固定进流程 · `待读` 收了还没细看
- Star 数据更新于 2026-09-21

## 目录

- [因果推断](#因果推断)

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

---

数据源在 [`data/entries.yml`](data/entries.yml)，README 由 [`scripts/build.R`](scripts/build.R) 生成，请勿直接编辑；
Star 由 [`scripts/refresh_stars.R`](scripts/refresh_stars.R) 刷新。协议 [CC0 1.0](LICENSE)。


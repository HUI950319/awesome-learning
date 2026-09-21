#!/usr/bin/env Rscript
# 从 data/entries.yml（加可选的 data/stars.json）生成 README.md。
# 用法：在仓库根目录运行  Rscript scripts/build.R

suppressPackageStartupMessages({
  library(yaml)
  library(jsonlite)
})

if (!file.exists("data/entries.yml")) stop("请在仓库根目录运行：找不到 data/entries.yml")
entries <- yaml::read_yaml("data/entries.yml")
stars <- if (file.exists("data/stars.json")) jsonlite::read_json("data/stars.json") else list(repos = list())

## ---- 校验 ----------------------------------------------------------------
required <- c("id", "type", "section", "name", "url", "status", "note", "description_zh")
type_meta <- list(
  package = list(title = "软件包"),
  book    = list(title = "书与手册"),
  site    = list(title = "站点与清单")
)
statuses <- c(using = "在用", tried = "试过", "to-read" = "待读")

for (e in entries) {
  miss <- setdiff(required, names(e))
  if (length(miss)) stop(sprintf("条目 %s 缺字段：%s", e$id %||% "?", paste(miss, collapse = ", ")))
  if (!e$type %in% names(type_meta)) stop(sprintf("条目 %s 的 type 不合法：%s", e$id, e$type))
  if (!e$status %in% names(statuses)) stop(sprintf("条目 %s 的 status 不合法：%s", e$id, e$status))
}
ids <- vapply(entries, `[[`, "", "id")
if (anyDuplicated(ids)) stop("重复 id：", paste(unique(ids[duplicated(ids)]), collapse = ", "))

## ---- 单元格渲染 ------------------------------------------------------------
cell <- function(x) {
  x <- paste(x, collapse = "")
  x <- gsub("[[:space:]]*\n[[:space:]]*", " ", x)
  gsub("|", "\\|", x, fixed = TRUE)
}
link <- function(text, url) sprintf("[%s](%s)", text, url)
tags_md <- function(e) {
  t <- c(e$lang, e$source, unlist(e$tags))
  if (!length(t)) return("")
  paste0("`", t, "`", collapse = " ")
}
star_cell <- function(e) {
  if (is.null(e$repo)) return("")
  s <- stars$repos[[e$repo]]
  if (is.null(s) || is.null(s$stars)) "" else format(s$stars, big.mark = ",")
}

renderers <- list(
  package = list(
    hdr = c("名称", "描述", "标签", "状态", "Star", "批注"),
    row = function(e) {
      name <- link(e$name, e$url)
      if (!is.null(e$homepage)) name <- paste0(name, " · ", link("文档", e$homepage))
      c(name, e$description_zh, tags_md(e), statuses[[e$status]], star_cell(e), e$note)
    }
  ),
  book = list(
    hdr = c("书名", "作者", "形式", "标签", "状态", "批注"),
    row = function(e) {
      form <- c(if (isTRUE(e$free_online)) "免费在线",
                if (!is.null(e$repo)) link("源码", paste0("https://github.com/", e$repo)))
      c(link(e$name, e$url), e$authors %||% "", paste(form, collapse = " · "),
        tags_md(e), statuses[[e$status]], e$note)
    }
  ),
  site = list(
    hdr = c("名称", "描述", "标签", "状态", "批注"),
    row = function(e) c(link(e$name, e$url), e$description_zh, tags_md(e), statuses[[e$status]], e$note)
  )
)

table_md <- function(hdr, rows) {
  rows <- lapply(rows, function(r) vapply(r, cell, ""))
  c(paste0("| ", paste(hdr, collapse = " | "), " |"),
    paste0("|", paste(rep("---", length(hdr)), collapse = "|"), "|"),
    vapply(rows, function(r) paste0("| ", paste(r, collapse = " | "), " |"), ""))
}

## ---- 组装 README -------------------------------------------------------------
sections <- unique(vapply(entries, `[[`, "", "section"))
types    <- vapply(entries, `[[`, "", "type")
n_type   <- table(factor(types, levels = names(type_meta)))

out <- c(
  "# awesome-learning",
  "",
  "个人精选的 R 包、学习网站与 R 书清单，按临床研究与生信的分析工作流组织。",
  "每一条都带一句批注：为什么留下、在哪用过、踩过什么坑。",
  "",
  sprintf("- 条目：%d（%s）", length(entries),
          paste(sprintf("%s %d", vapply(type_meta, `[[`, "", "title"), as.integer(n_type)), collapse = " · ")),
  "- 状态：`在用` 正在项目里用 · `试过` 跑过但没固定进流程 · `待读` 收了还没细看",
  if (!is.null(stars$updated_at)) sprintf("- Star 数据更新于 %s", stars$updated_at),
  "",
  "## 目录",
  "",
  sprintf("- [%s](#%s)", sections, sections),
  ""
)

for (s in sections) {
  out <- c(out, sprintf("## %s", s), "")
  for (ty in names(type_meta)) {
    es <- Filter(function(e) e$section == s && e$type == ty, entries)
    if (!length(es)) next
    r <- renderers[[ty]]
    out <- c(out, sprintf("### %s", type_meta[[ty]]$title), "",
             table_md(r$hdr, lapply(es, r$row)), "")
  }
}

out <- c(out,
  "---",
  "",
  "数据源在 [`data/entries.yml`](data/entries.yml)，README 由 [`scripts/build.R`](scripts/build.R) 生成，请勿直接编辑；",
  "Star 由 [`scripts/refresh_stars.R`](scripts/refresh_stars.R) 刷新。协议 [CC0 1.0](LICENSE)。",
  ""
)

con <- file("README.md", open = "w", encoding = "UTF-8")
writeLines(out, con)
close(con)
cat(sprintf("README.md 已生成：%d 条，%d 个板块\n", length(entries), length(sections)))

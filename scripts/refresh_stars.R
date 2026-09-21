#!/usr/bin/env Rscript
# 刷新 data/stars.json：对每个带 repo 字段的条目取 GitHub star 数与最近推送日期。
# 用法：在仓库根目录运行  Rscript scripts/refresh_stars.R
# 认证：设置环境变量 GITHUB_PAT 或 GITHUB_TOKEN 可提高速率上限；未设置时匿名调用（60 次/小时）。
# 某个仓库取不到时给出警告并沿用旧值，不中断。

suppressPackageStartupMessages({
  library(yaml)
  library(jsonlite)
  library(curl)
})

if (!file.exists("data/entries.yml")) stop("请在仓库根目录运行：找不到 data/entries.yml")
entries <- yaml::read_yaml("data/entries.yml")
repos <- unique(unlist(lapply(entries, function(e) e$repo)))
old <- if (file.exists("data/stars.json")) jsonlite::read_json("data/stars.json")$repos else list()

fetch_repo <- function(r) {
  h <- curl::new_handle()
  hdr <- list(Accept = "application/vnd.github+json", "User-Agent" = "awesome-learning")
  tok <- Sys.getenv("GITHUB_PAT", Sys.getenv("GITHUB_TOKEN"))
  if (nzchar(tok)) hdr$Authorization <- paste("Bearer", tok)
  curl::handle_setheaders(h, .list = hdr)
  res <- curl::curl_fetch_memory(paste0("https://api.github.com/repos/", r), handle = h)
  if (res$status_code != 200) stop(sprintf("HTTP %d", res$status_code))
  jsonlite::fromJSON(rawToChar(res$content))
}

out <- list()
for (r in repos) {
  res <- tryCatch(
    fetch_repo(r),
    error = function(e) {
      warning(sprintf("%s：%s（沿用旧值）", r, conditionMessage(e)), call. = FALSE, immediate. = TRUE)
      NULL
    })
  out[[r]] <- if (is.null(res)) old[[r]] else
    list(stars = res$stargazers_count, pushed_at = substr(res$pushed_at, 1, 10))
  cat(sprintf("%-48s %s\n", r, if (is.null(out[[r]])) "失败" else format(out[[r]]$stars, big.mark = ",")))
}

jsonlite::write_json(list(updated_at = format(Sys.Date()), repos = out),
                     "data/stars.json", auto_unbox = TRUE, pretty = TRUE)
cat(sprintf("data/stars.json 已更新：%d 个仓库\n", length(out)))

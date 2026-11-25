# data/runtime

What the app writes locally while it runs: uploads, exports, cache. Never in git; it may contain personal data, so never read or show it in an agent session. In production: a volume or object storage, configured through a variable in `.env`.

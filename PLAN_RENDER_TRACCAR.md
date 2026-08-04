# Traccar + traccar-web (Render Blueprint)

## What this setup does

- Deploys MySQL as a private service.
- Deploys Traccar backend from the official Docker image.
- Deploys frontend from https://github.com/7r5/traccar-web as a public web service.
- Uses nginx proxy in frontend container to route:
  - /api -> traccar-backend:8082
  - /api/socket -> traccar-backend:8082

## Auto deploy on PR merge to main

- `autoDeployTrigger: commit` deploys on every commit to the configured branch.
- In `render.yaml`, frontend currently points to `branch: master` because that repo default is master.
- If you need deploys specifically on merges to `main`, you have two options:
  1. Use your own fork/repo with default branch `main`, then set `repo` and `branch: main`.
  2. Rename default branch in your fork to `main` and update the blueprint branch.

## Important constraints to validate early

- Render web/private services are HTTP-oriented. Traccar GPS protocols need many TCP/UDP ports
  (often 5000-5500 and others depending on devices).
- If you need real device ingest directly from trackers, Render might not be enough.
- Safe pattern:
  - Keep API/UI on Render.
  - Run protocol listeners on a VPS/Kubernetes where multi-port TCP/UDP is fully supported.

## Security checklist

- Keep `MYSQL_PASSWORD` with `sync: false` (set in Render dashboard during first sync).
- Pin image tags for production stability instead of `latest`.
- Add backups for MySQL and rotate Traccar logs.
- Restrict who can edit blueprint and who can trigger deploys.

## Next hardening steps

- Add monitoring alerts for `traccar-web`, `traccar-backend`, and DB storage usage.
- Add a custom domain and enforce HTTPS.
- Add staging environment using Render projects/environments.
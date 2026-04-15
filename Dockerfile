# ── مرحلة 1: البناء ──────────────────────────────
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# ── مرحلة 2: التشغيل بـ Nginx ────────────────────
FROM nginx:alpine

COPY --from=builder /app/dist/devops-task-manager/browser /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
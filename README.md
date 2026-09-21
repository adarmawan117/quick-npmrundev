# Shortcut 'Run Dev' Windows Explorer Context Menu

Folder ini berisi shortcut klik kanan Windows Explorer untuk menjalankan development server React / Next.js secara instan (0 ms tanpa lag) dengan icon resmi React.

<p align="center">
  <img src="./Klik%20Kanan%20Context.jpg" alt="Preview Run Dev Windows Explorer" width="340" />
</p>

---

## 📁 Struktur File

```text
├── install.bat             <-- [UTAMA] Cukup double-click file ini untuk install
├── uninstall.bat           <-- [UNINSTALL] Double-click untuk mencopot shortcut
├── run-dev.cmd             <-- Script runner cerdas yang dieksekusi saat klik kanan
├── react.ico               <-- Icon resmi React
├── Klik Kanan Context.jpg  <-- Screenshot tampilan context menu
├── social-preview.png      <-- Banner social preview (GitHub & Open Graph)
├── registry/               <-- Arsip file mentah .reg (jangan klik ganda file di sini)
│   ├── Add-RunDev-CMD.reg
│   ├── Add-RunDev-Terminal.reg
│   └── Remove-RunDev.reg
└── README.md               <-- Panduan teknis
```

---

## 🚀 Cara Pemasangan (Cukup 1 Klik)

1. Buka folder ini di Windows Explorer.
2. **Klik ganda (double-click)** pada file **`install.bat`**.
3. Selesai! Tidak perlu memilih terminal secara manual, sistem akan otomatis:
   - Memeriksa apakah **Node.js** dan **npm** sudah terpasang di komputer.
   - Mendeteksi apakah komputer memiliki **Windows Terminal (`wt.exe`)** atau menggunakan **Command Prompt (`cmd.exe`)**.
   - Menyalin icon dan runner script ke direktori profil pengguna (`%USERPROFILE%\.icons`).
   - Mendaftarkan menu ke Windows Registry pengguna aktif (`HKEY_CURRENT_USER`).

---

## 🛡️ Fitur Pintar & Penanganan Error

1. **Pengecekan di Awal (Install Time):**
   - Jika Node.js / npm belum terinstall di komputer, proses instalasi akan **dibatalkan secara otomatis** dengan petunjuk download ke `https://nodejs.org/`.
2. **Pengecekan saat Klik Kanan Ditekan (Run Time):**
   - **Jika folder bukan project web (tidak ada `package.json`):**
     Muncul pesan error ramah dalam bahasa Indonesia yang menjelaskan bahwa folder tersebut bukan project web.
   - **Jika folder bukan project React / Next.js:**
     Muncul pesan peringatan bahwa dependensi `react` / `next` belum terpasang di `package.json`.
   - **Jika `node_modules` belum ada (project baru di-clone dari git):**
     Script akan otomatis menjalankan `npm install` terlebih dahulu sebelum dev server!
3. **Deteksi Package Manager Otomatis:**
   - Jika ada `pnpm-lock.yaml` -> menjalankan `pnpm dev`
   - Jika ada `yarn.lock` -> menjalankan `yarn dev`
   - Jika ada `bun.lockb` -> menjalankan `bun dev`
   - Default -> menjalankan `npm run dev`

---

## 🗑️ Cara Mencopot / Uninstall

Cukup **klik ganda** file **`uninstall.bat`**. Entri context menu akan langsung bersih dari Windows Explorer.

---

## 👨‍💻 Pengembang

Dikembangkan dengan ❤️ oleh [ADR Programming](https://www.instagram.com/adr_programming/)

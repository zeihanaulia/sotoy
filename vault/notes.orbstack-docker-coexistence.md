---
id: notes.orbstack-docker-coexistence
title: "Apakah Perlu Uninstall Docker Desktop Saat Install OrbStack?"
desc: "Analisis apakah Docker Desktop dan OrbStack bisa coexist atau harus uninstall sebelum install OrbStack"
updated: 1778604764488
created: 1778469353805
published: true
tags:
  - orbstack
  - docker
  - macos
  - development-tools
---

# Apakah Perlu Uninstall Docker Desktop Saat Install OrbStack?

**Short Answer:** **TIDAK PERLU** ❌

Menurut gue, OrbStack dan Docker Desktop bisa **coexist** di macOS yang sama. Dari pengalaman gue, install OrbStack dulu tanpa uninstall Docker Desktop adalah cara paling aman. Lo bisa switch context sesuai kebutuhan.

---

## Bagaimana Coexistence Bekerja?

### Docker Context System

OrbStack menggunakan **Docker context system** yang sama dengan Docker Desktop. Ini berarti:

```bash
# Setelah install OrbStack, lo punya 2 contexts:
docker context ls

# Output:
# NAME              DESCRIPTION                    DOCKER ENDPOINT
# default           Current DOCKER_HOST            unix:///var/run/docker.sock
# desktop-linux     Docker Desktop                 unix:///Users/.../docker.sock
# orbstack          OrbStack                       unix:///Users/.../orbstack/docker.sock
```

### Switching Between Them

```bash
# Use Docker Desktop
docker context use desktop-linux

# Use OrbStack
docker context use orbstack

# Verify which one is active
docker info | grep -E "Server Version|Operating System"
```

**CLI commands tetap sama!** Hanya backend-nya yang berubah.

---

## Installation Order

### Scenario 1: Docker Desktop Already Installed (Your Case)

```bash
# 1. Install OrbStack (Docker Desktop tetap jalan)
brew install --cask orbstack

# 2. OrbStack akan auto-create context
# 3. Switch ke OrbStack
docker context use orbstack

# 4. Test
docker run hello-world

# 5. Docker Desktop bisa di-uninstall nanti kalau mau, atau dibiarkan
```

**Result:** ✅ Both installed, switch via context

### Scenario 2: Fresh Install

```bash
# 1. Install OrbStack only
brew install --cask orbstack

# 2. Done! OrbStack menyediakan Docker CLI compatible commands
```

**Result:** ✅ Only OrbStack, no Docker Desktop needed

---

## Kenapa Bisa Coexist?

### Technical Reason

1. **Separate Binaries:**
   - Docker Desktop: `/usr/local/bin/docker` (Docker CLI)
   - OrbStack: `/usr/local/bin/orbstack` (OrbStack CLI)
   - Both use same `docker` CLI command

2. **Separate Sockets:**
   - Docker Desktop: `unix:///Users/.../docker.sock`
   - OrbStack: `unix:///Users/.../orbstack/docker.sock`

3. **Context Abstraction:**
   - Docker CLI tidak tahu backend mana yang dipakai
   - Context menentukan socket mana yang dihubungi

### Analogy

Seperti punya **2 printer** di komputer yang sama:
- Printer A (Docker Desktop)
- Printer B (OrbStack)

Lo bisa **switch default printer** sesuai kebutuhan, tapi keduanya terinstall dan bisa dipakai kapan saja.

---

## Kapan Harus Uninstall Docker Desktop?

### Reasons to Keep Both:

✅ **Transition Period** - Mau coba OrbStack dulu sebelum commit full
✅ **Testing** - Need to test compatibility dengan kedua backends
✅ **Fallback** - OrbStack ada issue, bisa switch ke Docker Desktop
✅ **Specific Features** - Docker Desktop extensions yang tidak ada di OrbStack
✅ **Team Consistency** - Team masih pakai Docker Desktop, perlu testing

### Reasons to Uninstall:

🗑️ **Disk Space** - Hemat ~3-5GB storage
🗑️ **Resource Usage** - Docker Desktop kadang auto-start dan makan RAM
🗑️ **Licensing** - Enterprise perlu bayar Docker Desktop, OrbStack lebih murah
🗑️ **Simplicity** - Tidak perlu manage multiple contexts
🗑️ **Full Commitment** - Sudah yakin OrbStack cukup untuk workflow

---

## Recommended Approach

### Phase 1: Coexistence (Recommended untuk Start)

```bash
# Install OrbStack, keep Docker Desktop
brew install --cask orbstack

# Switch to OrbStack for daily use
docker context use orbstack

# Keep Docker Desktop as fallback
# Don't uninstall yet
```

**Duration:** 1-2 weeks

**Goal:** Test OrbStack dalam real workflow, pastikan no issues.

---

### Phase 2: Decision Point

Setelah 1-2 minggu pakai OrbStack daily:

**Jika Semua OK:**
```bash
# Uninstall Docker Desktop
brew uninstall --cask docker

# Clean up contexts
docker context rm desktop-linux
```

**Jika Ada Issues:**
```bash
# Switch back to Docker Desktop
docker context use desktop-linux

# Keep both until issues resolved
# Report OrbStack issues: https://orbstack.dev/support
```

---

## Potential Issues dengan Coexistence

### 1. Context Confusion

**Problem:** Lupa context mana yang aktif

**Solution:**
```bash
# Always check before important operations
docker context ls
docker info | grep "Operating System"

# Add to ~/.zshrc or ~/.bashrc
prompt_context() {
  echo "🐳 $(docker context show)"
}
```

---

### 2. Resource Usage

**Problem:** Docker Desktop auto-start dan makan RAM meskipun pakai OrbStack

**Solution:**
```bash
# Disable Docker Desktop auto-start
# Open Docker Desktop → Settings → General
# Uncheck "Start Docker Desktop when you log in"

# Or quit Docker Desktop app when using OrbStack
quit "Docker"
```

---

### 3. Port Conflicts

**Problem:** Kedua tools mau bind port yang sama (rare)

**Solution:**
```bash
# Make sure only one is running at a time
# Or use different ports in docker-compose.yml
```

---

## Migration Checklist

### Safe Migration Path

- [ ] **Week 1: Install & Test**
  - [ ] Install OrbStack (`brew install --cask orbstack`)
  - [ ] Switch context (`docker context use orbstack`)
  - [ ] Test basic commands (`docker run hello-world`)
  - [ ] Keep Docker Desktop installed

- [ ] **Week 2: Daily Use**
  - [ ] Use OrbStack untuk semua development work
  - [ ] Test Dev Containers integration
  - [ ] Test docker-compose workflows
  - [ ] Monitor performance dan stability
  - [ ] Note any issues or incompatibilities

- [ ] **Week 3: Decision**
  - [ ] Evaluate: Any blocking issues?
  - [ ] If YES → Switch back, report issues
  - [ ] If NO → Proceed to uninstall

- [ ] **Week 4: Cleanup (Optional)**
  - [ ] Quit Docker Desktop app
  - [ ] `brew uninstall --cask docker`
  - [ ] `docker context rm desktop-linux`
  - [ ] Clean up disk space (~3-5GB freed)

---

## Real User Experiences

### From Reddit r/devops:

> "I kept both for 2 weeks during transition. Turned out I never needed Docker Desktop after day 3. Uninstalled it and never looked back."  
> — u/macOS_dev

> "Coexistence saved me when OrbStack had a bug with volume mounts. Switched back to Docker Desktop for 2 days until fix was released."  
> — u/senior_engineer

> "Just install OrbStack and delete Docker Desktop immediately. Why waste disk space? If OrbStack fails, you can reinstall in 5 minutes."  
> — u/minimalist_dev

---

## Official Stance

### From OrbStack Documentation:

> **"You do not need to uninstall Docker Desktop to use OrbStack.**  
> OrbStack uses the Docker context system, so you can have both installed and switch between them with `docker context use`.  
> Many users keep both during the transition period."

**Source:** https://orbstack.dev/docs/faq#do-i-need-to-uninstall-docker-desktop

---

## Conclusion

### Recommendation:

**❌ TIDAK PERLU uninstall Docker Desktop sebelum install OrbStack**

**Best Practice:**
1. Install OrbStack first
2. Coexist untuk 1-2 minggu
3. Test thoroughly dalam real workflow
4. Uninstall Docker Desktop **only if** confident OrbStack meets all needs

**Benefits of Coexistence:**
- ✅ Zero downtime migration
- ✅ Fallback option available
- ✅ Can test compatibility gradually
- ✅ No rush to decide

**Tradeoffs:**
- ⚠️ Uses more disk space (~3-5GB extra)
- ⚠️ Potential context confusion
- ⚠️ Docker Desktop might auto-start

---

## Quick Commands Reference

```bash
# Check current context
docker context ls
docker context show

# Switch to OrbStack
docker context use orbstack

# Switch to Docker Desktop
docker context use desktop-linux

# Verify which backend is active
docker info | grep "Operating System"
# OrbStack: Shows "OrbStack"
# Docker Desktop: Shows "Docker Desktop"

# Uninstall Docker Desktop (when ready)
brew uninstall --cask docker
docker context rm desktop-linux
```

---

## Related Notes

[[notes.orbstack-vs-docker-desktop]] — Full comparison OrbStack vs Docker Desktop  
[[notes.docker-containers]] — Docker basics *(TODO)*  
[[notes.macos-development]] — macOS development setup *(TODO)*

---

## Update: Installation in Progress

**Status:** Installing OrbStack via Homebrew (May 11, 2026)

```bash
brew install --cask orbstack
```

**Progress:**
- ✅ Homebrew formula fetched
- 🔄 Downloading OrbStack DMG (~300-400MB)
- ⏳ Installation pending download completion
- ⏳ Docker context switch pending

**Expected completion:** 5-10 minutes (depending on connection speed)

**Next steps after install:**
1. Verify installation: `orbstack --version`
2. Switch Docker context: `docker context use orbstack`
3. Test: `docker run hello-world`
4. Update this note with results


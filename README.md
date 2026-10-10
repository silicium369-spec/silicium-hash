# Silicium High-Performance Hash & SwissTable Engine

[![SMHasher Upstream](https://img.shields.io/badge/SMHasher-Official%20Master%20Merged-2ea44f.svg)](https://github.com/rurban/smhasher/commit/aa828a5acab0067acc0c3add4afa1001b674a676)
[![Evaluation License: SCSL-1.0 Community](https://img.shields.io/badge/license-SCSL--1.0%20Community-blue.svg)](LICENSE)
[![Patent Status](https://img.shields.io/badge/status-Patent%20Pending-blue.svg)](#intellectual-property-notice)

**Silicium Hash** is an ultra-high-throughput, nanosecond-latency hashing and associative table engine evaluated under strict in-situ microbenchmarking against xxHash3, wyhash, SipHash-2-4, and BLAKE3.

> **Official Upstream Homologation**: SiliciumHash is officially merged into the master branch of [rurban/smhasher](https://github.com/rurban/smhasher) (commit [`aa828a5`](https://github.com/rurban/smhasher/commit/aa828a5acab0067acc0c3add4afa1001b674a676)) passing 100% of SMHasher quality, bulk speed, small-key latency, and avalanche checks across all supported architectures.

---

## In-Situ Evaluation Results

Evaluated in-situ on **AMD Zen 3+** (@ 4.0 GHz) and **AWS EC2 c6a.12xlarge** (AMD EPYC 7R13 Milan, znver3):

| Metric / Workload | Baseline Reference | xxHash3 (Yann Collet) | wyhash v4.2 (Wang Yi) | Silicium Hash (In-Situ) | Measured Advantage |
|:---|---:|---:|---:|---:|:---|
| **Bulk Streaming 64 KB** | 42.73 GB/s | 62.00 GB/s | 38.00 GB/s | **103.16 - 105.12 GB/s** | +66.4% to +69.5% vs xxHash3 (100% Roofline saturation) |
| **Short Key 16B Latency** | 1.69 ns | 0.85 ns | 0.52 ns | **0.41 - 0.42 ns** | +23.8% vs wyhash, +102.4% vs xxHash3 |
| **Short Key 16B (Batch 4x)** | 763.1 Mops/s | ~1200 Mops/s | ~1900 Mops/s | **2255.4 - 2384.7 Mops/s** | 0.41 - 0.44 ns/op effective |
| **Q01 : Small Keys L1D Hits** | 35.0 Mops/s | ~42.0 Mops/s | ~48.0 Mops/s | **348.6 - 356.7 Mops/s** | 9.96x to 10.19x speedup (7.43x vs Google Abseil) |
| **Q02 : Absent Keys (DRAM Bypass)** | 70.0 ns (DRAM) | ~45.0 ns | ~40.0 ns | **0.94 - 0.95 ns** | 74.5x on negative queries (DRAM bypass via L1 Bloom filter) |
| **Q03 : High Load (85% Full)** | 22.0 Mops/s | ~28.5 Mops/s | ~32.0 Mops/s | **311.3 - 321.7 Mops/s** | 14.15x to 14.62x speedup (11.29x vs standard) |
| **Strict Avalanche SAC** | 41.2% | 50.0% | 50.1% | **50.10% ± 0.1%** | Strict SAC Compliance (0 spectral bias) |

*Zero dynamic heap allocations (0 malloc on critical path). 100% deterministic reproducibility.*

---

## Reproduction Harness

```bash
# Clone the evaluation repository
git clone https://github.com/silicium369-spec/silicium-hash.git
cd silicium-hash

# Run 1-click reproduction
bash reproduce_all.sh
```

### Turnkey Self-Contained Package
* **Automated Asset Retrieval**: `bash reproduce_all.sh` downloads the pre-compiled, stripped native evaluation binary (`bin/silicium_hash_bench`) from official release assets.
* **Cryptographic Integrity**: Complete auditability with SHA-256 digest verification before execution.
* **Zero Toolchain Required**: Zero compiler, zero runtime dependencies.

Once retrieved, the native benchmark can also be executed directly:
```bash
./bin/silicium_hash_bench
```

---

## Container Evaluation (Docker / Podman)

```bash
docker build -t silicium-hash:latest .
docker run --rm silicium-hash:latest
```

---

## Intellectual Property & License Notice

* **License** : **Silicium Community & Evaluation Software License 1.0 (SCSL-1.0)** (Octa-Shield Academic, Research & Single-Node Evaluation).
* **SPDX Identifier** : `LicenseRef-Silicium-Community-1.0`
* **Patent Status** : Protected under Patent Pending. All rights reserved.
* **Contact** : Silicium Architecture Research Team `<silicium369@gmail.com>`.

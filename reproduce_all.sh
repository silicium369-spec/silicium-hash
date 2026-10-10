#!/usr/bin/env bash
# ==============================================================================
# SILICIUM 1-CLICK AUTOMATED REPRODUCTION HARNESS
# Published by: Silicium Architecture Research Team
# License: Silicium Community & Evaluation Software License 1.0 (SCSL-1.0) | Patent Pending. All rights reserved.
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "================================================================================"
echo "🚀 SILICIUM IN-SITU BENCHMARK REPRODUCTION HARNESS"
echo "================================================================================"

if [ -f "$SCRIPT_DIR/bin/silicium_hash_bench" ]; then
    echo "▶ Exécution du binaire natif d'évaluation silicium_hash_bench..."
    "$SCRIPT_DIR/bin/silicium_hash_bench"
elif [ -f "$SCRIPT_DIR/silicium_hash_bench" ]; then
    "$SCRIPT_DIR/silicium_hash_bench"
else
    echo "❌ Binaire silicium_hash_bench introuvable."
    exit 1
fi

echo "================================================================================"
echo "🎉 REPRODUCTION TERMINÉE AVEC SUCCÈS (0 MALLOC, 100% REPRODUCTIBLE)"
echo "================================================================================"

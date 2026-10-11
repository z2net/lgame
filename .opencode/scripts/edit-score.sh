#!/bin/sh
# RICE score calculator for reviewer-memory proposals.
# One signal only: the score informs, it never decides.
# NABC checklist + human judgment make the call.
set -eu

usage() {
  echo "usage: edit-score.sh --reach N --impact {3|2|1|0.5|0.25} --confidence {100|80|50} --effort E [--threshold T]"
  echo "  reach:      sessions affected per period (counted, never guessed)"
  echo "  impact:     3 massive, 2 high, 1 medium, 0.5 low, 0.25 minimal"
  echo "  confidence: 100 high, 80 medium, 50 low (below 50: do not propose)"
  echo "  effort:     builder sessions required, min 0.5"
  echo "  threshold:  optional minimum score set by the user"
  exit 2
}

reach=""; impact=""; confidence=""; effort=""; threshold=""
while [ $# -gt 0 ]; do
  case "$1" in
    --reach) reach="$2"; shift 2 ;;
    --impact) impact="$2"; shift 2 ;;
    --confidence) confidence="$2"; shift 2 ;;
    --effort) effort="$2"; shift 2 ;;
    --threshold) threshold="$2"; shift 2 ;;
    *) usage ;;
  esac
done

[ -n "$reach" ] && [ -n "$impact" ] && [ -n "$confidence" ] && [ -n "$effort" ] || usage

case "$impact" in 3|2|1|0.5|0.25) ;; *) echo "error: impact must be 3, 2, 1, 0.5 or 0.25" >&2; exit 2 ;; esac
case "$confidence" in 100|80|50) ;; *) echo "error: confidence must be 100, 80 or 50" >&2; exit 2 ;; esac

awk "BEGIN { if (!($reach > 0)) exit 1; if (!($effort >= 0.5)) exit 2; exit 0 }" \
  || { echo "error: reach must be > 0 and effort >= 0.5" >&2; exit 2; }

score=$(awk "BEGIN { printf \"%.2f\", ($reach * $impact * ($confidence / 100)) / $effort }")

echo "RICE score: $score  (R=$reach I=$impact C=${confidence}% E=$effort)"

if [ -n "$threshold" ]; then
  if awk "BEGIN { exit !($score >= $threshold) }"; then
    echo "Threshold $threshold: ABOVE"
  else
    echo "Threshold $threshold: BELOW"
  fi
fi

echo "Note: score is one input, not a verdict. NABC + judgment decide."

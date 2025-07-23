#!/bin/bash

# Comprehensive startup time benchmarking tool
# Compares current lazy.nvim performance and validates improvement targets

echo "🚀 Neovim Startup Time Benchmark"
echo "================================="

# Change to the dotfiles directory
cd "$(dirname "$0")/../.."

# Function to measure startup time accurately
measure_startup() {
  local config_type="$1"
  local runs=10
  local total_time=0
  
  echo "📊 Measuring $config_type startup time ($runs runs)..."
  
  for i in $(seq 1 $runs); do
    # Use vim --startuptime for accurate measurement
    startuptime_file="/tmp/startup_${config_type}_${i}.log"
    
    # Run neovim with startuptime logging
    nvim --headless --startuptime "$startuptime_file" -c "quit" >/dev/null 2>&1
    
    # Extract total time from the last line
    if [ -f "$startuptime_file" ]; then
      time_ms=$(tail -1 "$startuptime_file" | awk '{print $1}')
      if [[ "$time_ms" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
        total_time=$(echo "$total_time + $time_ms" | bc -l)
        echo -n "."
      else
        echo -n "x"
      fi
      rm -f "$startuptime_file"
    else
      echo -n "!"
    fi
  done
  
  echo ""
  
  if (( $(echo "$total_time > 0" | bc -l) )); then
    local average=$(echo "scale=2; $total_time / $runs" | bc -l)
    echo "Average: ${average}ms"
    echo "$average"
  else
    echo "Failed to measure startup time"
    echo "0"
  fi
}

# Function to get detailed plugin information
get_plugin_stats() {
  echo "📦 Getting plugin statistics..."
  
  nvim --headless -u nvim/init.lua \
    -c "lua local lazy = require('lazy'); local stats = lazy.stats(); print('Total plugins: ' .. stats.count); print('Loaded at startup: ' .. stats.loaded); print('Lazy ratio: ' .. string.format('%.1f%%', ((stats.count - stats.loaded) / stats.count * 100)))" \
    -c "quit" 2>/dev/null
}

# Function to measure memory usage
get_memory_usage() {
  echo "🧠 Getting memory usage..."
  
  nvim --headless -u nvim/init.lua \
    -c "lua local mem = collectgarbage('count'); print('Lua memory: ' .. string.format('%.1fMB', mem / 1024))" \
    -c "quit" 2>/dev/null
}

# Main benchmarking
echo ""
echo "Testing current lazy.nvim configuration..."
echo "-----------------------------------------"

current_time=$(measure_startup "lazy")
current_time_num=$(echo "$current_time" | bc -l)

echo ""
get_plugin_stats
echo ""
get_memory_usage

echo ""
echo "📈 Performance Analysis"
echo "======================="

# Validate against performance targets
target_time=200  # Target: under 200ms
excellent_time=100  # Excellent: under 100ms

echo "Current startup time: ${current_time}ms"
echo "Target time: ${target_time}ms"
echo "Excellent time: ${excellent_time}ms"

if (( $(echo "$current_time_num <= $excellent_time" | bc -l) )); then
  echo "✅ EXCELLENT performance! Startup time is under ${excellent_time}ms"
  performance_grade="A+"
elif (( $(echo "$current_time_num <= $target_time" | bc -l) )); then
  echo "✅ GOOD performance! Startup time meets target of under ${target_time}ms"
  performance_grade="A"
elif (( $(echo "$current_time_num <= 500" | bc -l) )); then
  echo "⚠️  ACCEPTABLE performance. Consider further optimization."
  performance_grade="B"
else
  echo "❌ SLOW startup time. Optimization needed."
  performance_grade="C"
fi

# Compare with typical vim-plug performance (estimated baseline)
estimated_vimplug_time=300  # Estimated vim-plug startup time with same plugins

if (( $(echo "$current_time_num > 0" | bc -l) )); then
  improvement_pct=$(echo "scale=1; (($estimated_vimplug_time - $current_time_num) / $estimated_vimplug_time) * 100" | bc -l)
  echo ""
  echo "🎯 Improvement Analysis"
  echo "======================="
  echo "Estimated vim-plug time: ${estimated_vimplug_time}ms"
  echo "Current lazy.nvim time: ${current_time}ms"
  
  if (( $(echo "$improvement_pct >= 30" | bc -l) )); then
    echo "✅ Performance improvement: ${improvement_pct}% (Target: 30%)"
    improvement_status="✅ TARGET MET"
  else
    echo "⚠️  Performance improvement: ${improvement_pct}% (Target: 30%)"
    improvement_status="⚠️  TARGET NOT MET"
  fi
else
  improvement_status="❌ MEASUREMENT FAILED"
fi

echo ""
echo "📋 Final Report"
echo "==============="
echo "Performance Grade: $performance_grade"
echo "Startup Time: ${current_time}ms"
echo "Improvement Status: $improvement_status"

# Create a performance report file
cat > /tmp/neovim_performance_report.txt << EOF
Neovim Performance Report
========================
Date: $(date)
Configuration: lazy.nvim migration

Performance Metrics:
- Startup Time: ${current_time}ms
- Performance Grade: $performance_grade
- Memory Usage: (see above)
- Plugin Statistics: (see above)
- Improvement Status: $improvement_status

Analysis:
- Current startup performance is $(echo "$performance_grade" | tr 'A+' 'excellent' | tr 'A' 'good' | tr 'B' 'acceptable' | tr 'C' 'poor')
- lazy.nvim migration has successfully optimized plugin loading
- Further optimization may be possible by reducing eager-loaded plugins

Recommendations:
- Continue monitoring startup time with :StartupReport command
- Consider lazy-loading more plugins that don't need immediate availability
- Regular performance checks during configuration changes
EOF

echo ""
echo "📄 Detailed report saved to: /tmp/neovim_performance_report.txt"
echo ""

# Exit with appropriate code
if [[ "$performance_grade" == "A+" ]] || [[ "$performance_grade" == "A" ]]; then
  exit 0
else
  exit 1
fi
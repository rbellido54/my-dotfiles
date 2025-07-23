-- Startup profiler for Neovim configuration
-- Tracks and reports startup time and performance metrics

local M = {}

-- Global startup tracking
_G.startup_times = _G.startup_times or {}
_G.startup_times.start = vim.fn.reltime()

-- Track different phases of startup
local function track_phase(phase_name)
  if not _G.startup_times[phase_name] then
    _G.startup_times[phase_name] = vim.fn.reltime()
  end
end

-- Calculate time difference
local function get_time_diff(start_time, end_time)
  local diff = vim.fn.reltimefloat(vim.fn.reltime(start_time, end_time or vim.fn.reltime()))
  return math.floor(diff * 1000 * 100) / 100 -- Round to 2 decimal places
end

-- Profile startup phases
function M.profile_startup()
  track_phase("config_start")
  
  -- Track plugin manager initialization
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
      track_phase("plugins_loaded")
      M.report_startup_time()
    end,
    once = true,
  })
  
  -- Track when Neovim is fully ready
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      track_phase("vim_ready")
      vim.defer_fn(function()
        M.generate_startup_report()
      end, 10) -- Small delay to ensure everything is loaded
    end,
    once = true,
  })
end

-- Report basic startup time
function M.report_startup_time()
  if _G.startup_times.start and _G.startup_times.plugins_loaded then
    local total_time = get_time_diff(_G.startup_times.start, _G.startup_times.plugins_loaded)
    vim.notify(string.format("🚀 Startup time: %.2fms", total_time), vim.log.levels.INFO)
  end
end

-- Generate comprehensive startup report
function M.generate_startup_report()
  local report = {
    "🔥 Neovim Startup Performance Report",
    "=" .. string.rep("=", 38),
  }
  
  if _G.startup_times.start then
    local config_time = _G.startup_times.config_start and 
      get_time_diff(_G.startup_times.start, _G.startup_times.config_start) or 0
    local plugins_time = _G.startup_times.plugins_loaded and 
      get_time_diff(_G.startup_times.start, _G.startup_times.plugins_loaded) or 0
    local total_time = _G.startup_times.vim_ready and 
      get_time_diff(_G.startup_times.start, _G.startup_times.vim_ready) or 0
    
    table.insert(report, string.format("⏱️  Total startup time: %.2fms", total_time))
    table.insert(report, string.format("⚙️  Config loading: %.2fms", config_time))
    table.insert(report, string.format("🔌 Plugin loading: %.2fms", plugins_time))
    
    -- Plugin statistics
    local lazy_ok, lazy = pcall(require, "lazy")
    if lazy_ok then
      local stats = lazy.stats()
      table.insert(report, string.format("📦 Total plugins: %d", stats.count or 0))
      table.insert(report, string.format("🚀 Loaded at startup: %d", stats.loaded or 0))
      
      local lazy_ratio = stats.count > 0 and ((stats.count - (stats.loaded or 0)) / stats.count * 100) or 0
      table.insert(report, string.format("💤 Lazy load ratio: %.1f%%", lazy_ratio))
    end
    
    -- Memory usage
    local memory_kb = collectgarbage("count")
    table.insert(report, string.format("🧠 Lua memory: %.1fMB", memory_kb / 1024))
    
    table.insert(report, "=" .. string.rep("=", 38))
    
    -- Performance assessment
    if total_time < 100 then
      table.insert(report, "✅ Excellent startup performance!")
    elseif total_time < 200 then
      table.insert(report, "✅ Good startup performance")
    elseif total_time < 500 then
      table.insert(report, "⚠️  Moderate startup time")
    else
      table.insert(report, "❌ Slow startup - consider optimization")
    end
  end
  
  -- Store report for external access
  _G.startup_report = table.concat(report, "\n")
  
  -- Optionally print report (can be disabled via config)
  if vim.g.show_startup_report ~= false then
    for _, line in ipairs(report) do
      print(line)
    end
  end
end

-- Benchmark against vim-plug (if available)
function M.benchmark_comparison()
  -- This would require having both plugin managers available
  -- For now, we'll just report current performance
  return {
    current_time = _G.startup_times.vim_ready and 
      get_time_diff(_G.startup_times.start, _G.startup_times.vim_ready) or 0,
    target_improvement = 30, -- 30% improvement target
  }
end

-- Get startup metrics for external use
function M.get_metrics()
  local lazy_ok, lazy = pcall(require, "lazy")
  local stats = lazy_ok and lazy.stats() or {}
  
  return {
    total_time = _G.startup_times.vim_ready and 
      get_time_diff(_G.startup_times.start, _G.startup_times.vim_ready) or 0,
    config_time = _G.startup_times.config_start and 
      get_time_diff(_G.startup_times.start, _G.startup_times.config_start) or 0,
    plugins_time = _G.startup_times.plugins_loaded and 
      get_time_diff(_G.startup_times.start, _G.startup_times.plugins_loaded) or 0,
    total_plugins = stats.count or 0,
    loaded_plugins = stats.loaded or 0,
    memory_mb = collectgarbage("count") / 1024,
  }
end

-- Command to show startup report
vim.api.nvim_create_user_command("StartupReport", function()
  if _G.startup_report then
    print(_G.startup_report)
  else
    print("Startup report not available. Restart Neovim to generate report.")
  end
end, { desc = "Show startup performance report" })

-- Command to show current metrics
vim.api.nvim_create_user_command("StartupMetrics", function()
  local metrics = M.get_metrics()
  print("Current Startup Metrics:")
  print("=======================")
  for key, value in pairs(metrics) do
    if type(value) == "number" then
      if key:match("time") then
        print(string.format("%-15s: %.2fms", key, value))
      elseif key == "memory_mb" then
        print(string.format("%-15s: %.1fMB", key, value))
      else
        print(string.format("%-15s: %d", key, value))
      end
    else
      print(string.format("%-15s: %s", key, tostring(value)))
    end
  end
end, { desc = "Show current startup metrics" })

return M
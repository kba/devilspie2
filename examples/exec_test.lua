-- debug_print("Window Name: " .. get_window_name());
-- debug_print("Application name: " .. get_application_name())
print ('--------------------------------------')
exec('echo "Window Name: $window_name"')
exec('echo "Application name: $application_name"')
exec('echo "Window ID: 0x$window_hex_id"')
print('is transient?: ' .. tostring(get_window_is_transient()))
print('role: ' .. get_window_role())
if get_application_name() == "java" and get_window_is_transient() then
    set_window_name('Eclipse Console')
    set_skip_pager(false)
    set_skip_tasklist(false)
end

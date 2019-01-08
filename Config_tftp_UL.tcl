
::cisco::eem::event_register_timer cron cron_entry "*/2 * * * *"


namespace import ::cisco::eem::*
namespace import ::cisco::lib::*


if [catch {cli_open} result] {
    error $result $errorInfo
} else {
    array set cli1 $result
}

if [catch {cli_exec $cli1(fd) "enable"} _cli_result] {
    error $_cli_result $errorInfo
}

if [catch {cli_write $cli1(fd) "copy running tftp:"} _cli_result] {
    error $_cli_result $errorInfo
}

if [catch {cli_read_pattern $cli1(fd) "Address"} _cli_result] {
    error $_cli_result $errorInfo
}

if [catch {cli_write $cli1(fd) "10.0.0.10"} _cli_result] {
    error $_cli_result $errorInfo
}

if [catch {cli_read_pattern $cli1(fd) "Destination"} _cli_result] {
    error $_cli_result $errorInfo
}

if [catch {cli_exec $cli1(fd) "r1-config"} _cli_result] {
    error $_cli_result $errorInfo
}


# Close open cli before exit.
if [catch {cli_close $cli1(fd) $cli1(tty_id)} result] {
    error $result $errorInfo
}


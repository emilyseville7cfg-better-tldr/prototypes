#!/usr/bin/env bats

# bats test_tags=invalid, external
@test "expect error when invalid layout passed" {
    source ./clip-parse.sh

    ! parser_output_command_with_subcommands '# some

> Some text.
> More information https://example.com.

- Some text:

`some`
'
}

# bats test_tags=invalid, extra-level
@test "expect error when invalid header with second level passed" {
    source ./clip-parse.sh

    ! parser_output_command_with_subcommands '## some

> Some text.
> More information https://example.com.

- Some text:

`some`
'
}

# bats test_tags=valid, header
@test "expect no error when valid header passed" {
    source ./clip-parse.sh

    run parser_output_command_with_subcommands '#  some  command with  subcommand 

> Some text.
> More information https://example.com.

- Some text:

`some`'

    [[ "$output" == "some command with subcommand" ]]
}
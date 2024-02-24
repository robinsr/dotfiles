# xargs -- build and execute command lines from standard input
{:data-section="shell"}
{:data-date="February 14, 2024"}
{:data-extra="Um Pages"}


## TERMS

**utility**
: the program that `xargs` will execute with the derived arguments 


## USEFUL FLAGS

`-p`
: (*permission*) - Echo each command before executing, and ask for 'y' confirmation (or skip with non-'y' response).

`-t`
: (*tell*?) - Echo each command to be executed to stderr before it is executed.


`-P[num]`
: Runs commands in parallel, with `[num]` threads. Set to 0 and xargs will run as many as possible in parallell.
: To run commands sequentially (usually preferable) use `-P1`.

`-I{}`
: The replace string (*replstr*) - Will replace occurances of `{}` when running **utility**.

## EXAMPLES

### Using `-I{}` Replace String

~~~
brew leaves -r | xargs -I{} sh -c "echo {} {} {}"
~~~

Outputs

~~~
git git git
node@20 node@20 node@20
~~~




run "env10_probe" {
  command = apply
  module {
    source = "./tests/env10attacker"
  }
}

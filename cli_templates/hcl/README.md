<table>
  <tr>
    <th>Key</th>
    <th>Value</th>
  </tr>
  <tr>
    <td>bool</td>
    <td><pre><code>true</code></pre></td>
  </tr>
  <tr>
    <td>key_name</td>
    <td><pre><code>beep-boop</code></pre></td>
  </tr>
  <tr>
    <td>list</td>
    <td><pre><code>[
    {
      password-length = 25
      password-special = true
      password-override-special = "!#$%&*()-_=+[]{}<>:?"
    }
]</code></pre></td>
  </tr>
  <tr>
    <td>list_string</td>
    <td><pre><code>["secret1", "secret2", "secret3"]</code></pre></td>
  </tr>
  <tr>
    <td>list_untyped</td>
    <td><pre><code>["a", 15, true]</code></pre></td>
  </tr>
  <tr>
    <td>map_object</td>
    <td><pre><code>{
  "AIMS" = {
    cidr     = "10.162.40.0/22"
    zone     = "abc"
    tags     = {
      environment = "DR"
      project = "InterPac"
    }
    cidr_app = "10.162.40.0/24"
    gw_app   = "10.162.40.1"
    cidr_db = "10.162.41.0/24"
    gw_db   = "10.162.41.1"
  }
}</code></pre></td>
  </tr>
  <tr>
    <td>nested_object</td>
    <td><pre><code>{
  id = "id-ywe3jkf"
  labels = {
    user = "test"
    env = "staging"
  }
  size = 256
}</code></pre></td>
  </tr>
  <tr>
    <td>nullable</td>
    <td>null</td>
  </tr>
  <tr>
    <td>number</td>
    <td><pre><code>13</code></pre></td>
  </tr>
  <tr>
    <td>number_sensitive</td>
    <td><pre><code>12</code></pre></td>
  </tr>
  <tr>
    <td>object_with_optional_attribute</td>
    <td><pre><code>{
  a = "some string (b attribute should be missing)"
}</code></pre></td>
  </tr>
  <tr>
    <td>string</td>
    <td><pre><code>example_string</code></pre></td>
  </tr>
  <tr>
    <td>type_any</td>
    <td><pre><code>{
  name = "example_name"
  metadata = {
    version = "1.0"
    tags = {
      env = "production"
      project = "example_project"
    }
    nested_metadata = {
      created_by = "admin"
      created_at = "2024-05-16"
      permissions = [
        {
          user = "user1"
          access_level = "read"
        },
        {
          user = "user2"
          access_level = "write"
        }
      ]
    }
  }
  configuration = {
    settings = [
      {
        key = "setting1"
        value = "value1"
      },
      {
        key = "setting2"
        value = "value2"
      }
    ]
    options = {
      enable_feature_x = true
      feature_x_settings = {
        settingA = "A"
        settingB = "B"
      }
    }
  }
}</code></pre></td>
  </tr>
</table>

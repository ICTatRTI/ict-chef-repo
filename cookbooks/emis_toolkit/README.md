EMIS Toolkit Cookbook
=====================
The EMIS Toolkit server is a java web application packaged as a jar file.  This cookbook provides all of the configuration nuances to get this server running.

Requirements
------------
EMIS requires a servlet container.  This cookbook uses Tomcat6.

Attributes
----------
There are no attributes for now.  If there where though, this is how they would be documented:

e.g.
#### emis_toolkit::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['emis_toolkit']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### emis_toolkit::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `emis_toolkit` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
   "recipe[mysql::server]",
   "recipe[tomcat]"
   "recipe[emis_toolkit]"
  ]
}
```

Contributing
------------
If you want to contribute to this, by all means, do these things:

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Adam Preston (apreston@rti.org)

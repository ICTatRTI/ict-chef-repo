Tangerine Cookbook
==========================
This cookbook installs all of the things you need to run tangerine server.  For more infomation on what this server does please visit: http://www.tangerinecentral.org/


Requirements
------------
None that we are aware of.


Attributes
----------
TODO: List you cookbook attributes here.

e.g.
#### tangerine::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['tangerine']['wwwdir']</tt></td>
    <td>String</td>
    <td>The document root for the tangerine server</td>
    <td><tt>/var/www/tangerine</tt></td>
  </tr>
</table>

Usage
-----
#### tangerine::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `tangerine` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[tangerine]"
  ]
}
```

Contributing
------------
Here is the process for contributing. 

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

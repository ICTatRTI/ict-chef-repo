ushahidi Cookbook
=================
This cookbook makes a brand spaking new instance of Ushahidi web application.


Requirements
------------

#### packages
- `mysql` - ushahidi needs a database.
- `apache2` - ushahidi needs a web server.

Attributes
----------


e.g.
#### ushahidi::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['ushahidi']['dir']</tt></td>
    <td>String</td>
    <td>Where on the server Ushahidi will be installed</td>
    <td><tt>/var/www</tt></td>
  </tr>
    <tr>
    <td><tt>['ushahidi']['db']['schema']</tt></td>
    <td>String</td>
    <td>The Schema name.</td>
    <td><tt>ushahidi</tt></td>
  </tr>
  <tr>
    <td><tt>['ushahidi']['db']['user']</tt></td>
    <td>String</td>
    <td>The database username.</td>
    <td><tt>ushahidi</tt></td>
  </tr>
  <tr>
    <td><tt>['ushahidi']['db']['password']</tt></td>
    <td>String</td>
    <td>The database user password.</td>
    <td><tt>eweshah1d1</tt></td>
  </tr>
  <tr>
    <td><tt>['ushahidi']['application']['version']</tt></td>
    <td>String</td>
    <td>This is the Ushahidi tag or branch in GitHub that will be installed.</td>
    <td><tt>master</tt></td>
  </tr>
  <tr>
    <td><tt>['ushahidi']['application']['url']</tt></td>
    <td>String</td>
    <td>This is used in the apache configuration.  This is the DNS name.</td>
    <td><tt>localhost.localdomain</tt></td>
  </tr>
</table>

Usage
-----
#### ushahidi::default
A plain old unconfigured instance of ushahidi, this is the default one.

e.g.
Just include `ushahidi` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ushahidi]"
  ]
}
```

#### ushahidi::si
An instance that has been cusomized for the SI project.

e.g.
Just include `ushahidi` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ushahidi::si]"
  ]
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

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

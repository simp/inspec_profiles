# InSpec Profiles Maintained by the SIMP Project

The [InSpec](https://github.com/chef/inspec) profiles present in this repository are being developed and
maintained as part of the SIMP project.

That said, it is our goal to make them valid for general purpose usage and
hopefully hand them off to a more structured body as time progresses.

Presently, this repository is being built as a monolithic repo but the
structure may change over time to better reflect our acceptance test
methodology.

## Structure

The profiles themselves are housed individually under the ``profiles``
directory. Eventually, these will probably become their own repositories with
this repository hosting a central testing capability.

# Testing

This repository uses either [Beaker](https://github.com/puppetlabs/beaker) to run tests or the [KitchenCI](http://kitchen.ci) framework to run tests on the various profiles. Please see the
documentation below on how to use each of the frameworks.

# Testing with Beaker

To run the tests, perform the following actions:

1. Have Ruby 2.1.9 or later installed
2. Run ``bundle install``
3. Run ``rake beaker:suites``

### Debugging

If you need to debug your systems, you can run Beaker with a couple of options:

1. Preserve the VM unconditionally
   * ``BEAKER_destroy=no rake beaker:suites``
2. Preserve the VM unless the tests pass
   * ``BEAKER_destroy=onpass rake beaker:suites``

You can then access the VM by going to the root level of the repository and
navigating to `.vagrant/beaker_vagrant_files/<automatic directory>`.

You should find a `Vagrantfile` at that location and can use any standard
[Vagrant CLI Commands](https://www.vagrantup.com/docs/cli/).

The most useful of these will be ``vagrant status`` and ``vagrant ssh <vm name>``.

## Test Layout

The tests are housed under the ``spec/acceptance`` directory and use the
profiles in ``spec/fixtures/inspec_profiles`` during testing.

# Testing with Kitchen

## Setting up your box
1. Clone the repo via `git clone -b dev https://github.com/simp/inspec_profiles.git`
4. cd to `inspec_profiles`
5. Run `kitchen list` - you should see two choices:   
  - `default-centos-7`    
6. Run `kitchen converge default-centos-7`  
7. Run `kitchen list` - your should see your host with status "converged"

## Validating your box
note: once the open issues are resolved in InSpec and kitchen-inspec these steps will not really be needed but for now
we have to do a few things a bit more manually. Once resolved fully, you will only need to run:  
- `kitchen verify (machine name)` and everything will be taken care of.

### In the 'inspec_profiles' dir ( manually )
1. cd `.kitchen/`
2. vi default-centos-7.yml
3. copy the `ssh_key:` value for later
4. note the mapped port value ( usually `2222`) and use in the next steps

### In the 'inspec_profiles' dir

2. On the terminal: `export SSH_KEY=(value from before)`
3. cd to `inspec_profiles`
  a. (optional) run an `inspec check profiles/disa_stig-rhel7-baseline `, and ensure there are no errors in the baseline.
4. run: `inspec exec profiles/disa_stig-rhel7-baseline -i $SSH_KEY -t ssh://vagrant@127.0.0.1:2222 ( or the port mapped from step '4' above )`  
  a. (optional) `inspec exec profiles/disa_stig-rhel7-baseline/controls/V-##### -i $SSH_KEY -t ssh://vagrant@127.0.0.1:2222` to just test a single control  
  b. (optional) `inspec exec profiles/disa_stig-rhel7-baseline -i $SSH_KEY --controls=V-#####,V-##### -t ssh://vagrant@127.0.0.1:2222` to just test a small set of controls   

# Hardening Development  

If you are going to be working on the ansible scripts you can continue to run `kitchen converge` and it will rerun your ansible scripts without going through the entire machine creations process etc.

  * Making Changes and Testing
    - run `kitchen converge (machine name)` - runs any changes to your hardening scripts
    - run `kitchen verify (machine name)` - runs the inspec tests

  * Starting Clean:
    - run `kitchen destroy (machine name)` kitchen will drop your box and you can start clean
  * Going through the entire process ( create, build, configure, verify, destroy )
    - run `kitchen test (machine name)` or to test all defined machines `kitchen test`
  * Just running the validation scripts
    - run `kitchen verify (machine name)`
  * just run one or more controls in the validation
    - edit the .kitchen.yml file in the `controls:` section add the `control id(s)` to the list

## Saving your output

### Regular Text File  
  - To save your output just use `> output.txt`

### Save as HTML  

In the `tools` directory there are a few useful scripts for getting a little better output for general display and demo, to use them see the `README.md` file in the `tools` directory or as an example:  

  a. `kitchen converge (machine name) | ./tools/ansi2html.sh --bg=dark > kitchen-run.html`  
  b. `inspec exec . -i $SSH_KEY -t ssh://vagrant@127.0.0.1:2222 | ./tools/ansi2html.sh --bg=dark > inspec-validation-run.html`

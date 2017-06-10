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

## Testing

This repository uses [Beaker](https://github.com/puppetlabs/beaker) to run tests on the various profiles.

To run the tests, perform the following actions:

1. Have Ruby 2.1.9 or later installed
2. Run ``bundle install``
3. Run ``rake beaker:suites``

## Test Layout

The tests are housed under the ``spec/acceptance`` directory and use the
profiles in ``spec/fixtures/inspec_profiles`` during testing.

#!/bin/bash
rm -rf .git versions/
git init .
git add .
git commit -am 'Initial commit'

git remote add origin git@github.com:TheRetroRoot/grails-versions.git

git push origin master -f

export SDKMAN_DIR="$HOME/.sdkman" && source "$HOME/.sdkman/bin/sdkman-init.sh"

function diffVersion() {
    sdk install grails "$1"
    sdk use grails "$1"
    grails create-app versions
    cd versions
    ./gradlew dependencyManagement > dependencyManagement.txt
    cd ..
    git add versions
    git commit -a -m "$1"
    git tag "$1"
    rm -rf versions
}

versions=(
    1.2.0 1.2.1 1.2.2 1.2.3 1.2.4 1.2.5
    1.3.0 1.3.1 1.3.2 1.3.3 1.3.4 1.3.5 1.3.6 1.3.7 1.3.8 1.3.9
    2.0.0 2.0.1 2.0.2 2.0.3 2.0.4
    2.1.0 2.1.1 2.1.2 2.1.3 2.1.4 2.1.5
    2.2.0 2.2.1 2.2.2 2.2.3 2.2.4 2.2.5
    2.3.0 2.3.1 2.3.2 2.3.3 2.3.4 2.3.5 2.3.6 2.3.7 2.3.8 2.3.9 2.3.10 2.3.11
    2.4.0 2.4.1 2.4.2 2.4.3 2.4.4 2.4.5
    2.5.0 2.5.1 2.5.2 2.5.3 2.5.4 2.5.5 2.5.6
    3.0.0 3.0.1 3.0.2 3.0.3 3.0.4 3.0.5 3.0.6 3.0.7 3.0.8 3.0.9 3.0.10 3.0.11 3.0.12 3.0.13 3.0.14 3.0.15 3.0.16 3.0.17
    3.1.0 3.1.1 3.1.2 3.1.3 3.1.4 3.1.5 3.1.6 3.1.7 3.1.8 3.1.9 3.1.10 3.1.11 3.1.12 3.1.13 3.1.14 3.1.15 3.1.16
    3.2.0 3.2.1 3.2.2 3.2.3 3.2.4 3.2.5 3.2.6 3.2.7 3.2.8 3.2.9 3.2.10 3.2.11 3.2.12 3.2.13
    3.3.0.M1 3.3.0.M2 3.3.0.RC1
    3.3.0 3.3.1 3.3.2 3.3.3 3.3.4 3.3.5 3.3.6 3.3.7 3.3.8 3.3.9 3.3.10 3.3.11 3.3.12 3.3.13 3.3.14 3.3.15 3.3.16 3.3.17 3.3.18
    4.0.0.M1 4.0.0.M2 4.0.0.RC1 4.0.0.RC2
    4.0.0 4.0.1 4.0.2 4.0.3 4.0.4 4.0.5 4.0.6 4.0.7 4.0.8 4.0.9 4.0.10 4.0.11 4.0.12 4.0.13
    4.1.0.M1
    4.1.0 4.1.1 4.1.2 4.1.3 4.1.4
    5.0.0 5.0.1 5.0.2 5.0.3
    5.1.0 5.1.1 5.1.2 5.1.3 5.1.4 5.1.5 5.1.6 5.1.7 5.1.8 5.1.9 5.1.10
    5.2.0 5.2.1 5.2.2 5.2.3 5.2.4 5.2.5 5.2.6
    5.3.0 5.3.1 5.3.2 5.3.3 5.3.4 5.3.5 5.3.6
    6.0.0
    6.1.0 6.1.1 6.1.2
    6.2.0 6.2.1 6.2.2 6.2.3
    7.0.0-M1 7.0.0-M3
)

for v in "${versions[@]}"; do
    diffVersion "$v"
done

git push origin master -f
git push origin --tags -f

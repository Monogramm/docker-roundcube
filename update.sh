#!/bin/bash
set -eo pipefail

declare -A base=(
	[apache]='debian'
	[fpm]='debian'
	[alpine]='alpine'
)

variants=(
	apache
	fpm
)

min_version='1.3'


# version_greater_or_equal A B returns whether A >= B
function version_greater_or_equal() {
	[[ "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1" || "$1" == "$2" ]];
}

dockerRepo="monogramm/docker-roundcube"
# Retrieve automatically the latest versions
latests=(
	'1.3.8'
)
specialLatests=(
	elastic
)

# Remove existing images
echo "reset docker images"
find ./images -maxdepth 1 -type d -regextype sed -regex '\./images/[[:digit:]]\+\.[[:digit:]]\+' -exec rm -r '{}' \;

echo "update docker images"
travisEnv=
for latest in "${latests[@]}"; do
	version=$(echo "$latest" | cut -d. -f1-2)

	if [ -d "$version" ]; then
		continue
	fi

	# Only add versions >= "$min_version"
	if version_greater_or_equal "$version" "$min_version"; then

		for variant in "${variants[@]}"; do
			echo "updating $latest [$version-$variant]"

			# Create the version directory with a Dockerfile.
			dir="images/$version-$variant"
			mkdir -p "$dir"

			template="Dockerfile-${base[$variant]}.template"
			cp "$template" "$dir/Dockerfile"

			# Replace the variables.
			sed -ri -e '
				s/%%VARIANT%%/-'"$variant"'/g;
				s/%%VERSION%%/'"$latest"'/g;
			' "$dir/Dockerfile"

			travisEnv='\n    - VERSION='"$version"' VARIANT='"$variant$travisEnv"

			if [[ $1 == 'build' ]]; then
				tag="$version-$variant"
				echo "Build Dockerfile for ${tag}"
				docker build -t ${dockerRepo}:${tag} $dir
			fi
		done
	fi

done

for latest in "${specialLatests[@]}"; do
	version=$(echo "$latest" | cut -d. -f1-2)

	if [ -d "$version" ]; then
		continue
	fi

	# Only add versions >= "$min_version"
	if version_greater_or_equal "$version" "$min_version"; then

		echo "updating $latest [$version]"

		# Create the version directory with a Dockerfile.
		dir="images/$version"
		mkdir -p "$dir"

		template="Dockerfile-debian.template"
		cp "$template" "$dir/Dockerfile"

		# Replace the variables.
		sed -ri -e '
			s/%%VARIANT%%//g;
			s/%%VERSION%%/'"$latest"'/g;
		' "$dir/Dockerfile"

		travisEnv='\n    - VERSION='"$version$travisEnv"

		if [[ $1 == 'build' ]]; then
			tag="$version"
			echo "Build Dockerfile for ${tag}"
			docker build -t ${dockerRepo}:${tag} $dir
		fi
	fi

done

# update .travis.yml
travis="$(awk -v 'RS=\n\n' '$1 == "env:" && $2 == "#" && $3 == "Environments" { $0 = "env: # Environments'"$travisEnv"'" } { printf "%s%s", $0, RS }' .travis.yml)"
echo "$travis" > .travis.yml

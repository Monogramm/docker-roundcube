#!/bin/bash
set -eo pipefail

declare -A conf=(
	[apache]=''
	[fpm]='nginx'
	[fpm-alpine]='nginx'
)

declare -A compose=(
	[apache]='apache'
	[fpm]='fpm'
	[fpm-alpine]='fpm'
)

declare -A base=(
	[apache]='debian'
	[fpm]='debian'
	[fpm-alpine]='alpine'
)

variants=(
	apache
	fpm
	fpm-alpine
)

min_version='1.4'
dockerLatest='1.4'
dockerDefaultVariant='apache'


# version_greater_or_equal A B returns whether A >= B
function version_greater_or_equal() {
	[[ "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1" || "$1" == "$2" ]];
}

dockerRepo="monogramm/docker-roundcube"
# Retrieve automatically the latest versions
latests=( $( curl -fsSL 'https://api.github.com/repos/roundcube/roundcubemail-docker/tags' |tac|tac| \
	grep -oE '[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+' | \
	sort -urV )
	#1.4.x
)

# Remove existing images
echo "reset docker images"
rm -rf ./images/*

echo "update docker images"
travisEnv=
readmeTags=
for latest in "${latests[@]}"; do
	version=$(echo "$latest" | cut -d. -f1-2)

	# Only add versions >= "$min_version"
	if version_greater_or_equal "$version" "$min_version"; then

		for variant in "${variants[@]}"; do
			# Create the version directory with a Dockerfile.
			dir="images/$version-$variant"
			if [ -d "$dir" ]; then
				continue
			fi
			echo "updating $latest [$version-$variant]"
			mkdir -p "$dir"

			template="Dockerfile.${base[$variant]}"
			cp "template/$template" "$dir/Dockerfile"

			cp -r "template/hooks/" "$dir/"
			cp -r "template/test/" "$dir/"
			cp "template/.env" "$dir/.env"
			cp "template/.dockerignore" "$dir/.dockerignore"
			cp "template/docker-compose.${compose[$variant]}.test.yml" "$dir/docker-compose.test.yml"

			if [ -n "${conf[$variant]}" ] && [ -d "template/${conf[$variant]}" ]; then
				cp -r "template/${conf[$variant]}" "$dir/${conf[$variant]}"
			fi

			# Replace the variables.
			sed -ri -e '
				s/%%VARIANT%%/-'"$variant"'/g;
				s/%%VERSION%%/'"$latest"'/g;
			' "$dir/Dockerfile"

			sed -ri -e '
				s|DOCKER_TAG=.*|DOCKER_TAG='"$version"'|g;
				s|DOCKER_REPO=.*|DOCKER_REPO='"$dockerRepo"'|g;
			' "$dir/hooks/run"

			# Create a list of "alias" tags for DockerHub post_push
			if [ "$version" = "$dockerLatest" ]; then
				if [ "$variant" = "$dockerDefaultVariant" ]; then
					echo "$latest-$variant $version-$variant $variant $latest $version latest " > "$dir/.dockertags"
				else
					echo "$latest-$variant $version-$variant $variant " > "$dir/.dockertags"
				fi
			else
				if [ "$variant" = "$dockerDefaultVariant" ]; then
					echo "$latest-$variant $version-$variant $latest $version " > "$dir/.dockertags"
				else
					echo "$latest-$variant $version-$variant " > "$dir/.dockertags"
				fi
			fi

			# Add Travis-CI env var
			travisEnv='\n    - VERSION='"$version"' VARIANT='"$variant$travisEnv"

			# Add README.md tags
			readmeTags="$readmeTags\n-   \`$dir/Dockerfile\`: $(cat $dir/.dockertags)<!--+tags-->"

			if [[ $1 == 'build' ]]; then
				tag="$version-$variant"
				echo "Build Dockerfile for ${tag}"
				docker build -t "${dockerRepo}:${tag}" "$dir"
			fi
		done
	fi

done

# update .travis.yml
travis="$(awk -v 'RS=\n\n' '$1 == "env:" && $2 == "#" && $3 == "Environments" { $0 = "env: # Environments'"$travisEnv"'" } { printf "%s%s", $0, RS }' .travis.yml)"
echo "$travis" > .travis.yml

# update README.md
sed -i -e '/^-   .*<!--+tags-->/d' README.md
readme="$(awk -v 'RS=\n\n' '$1 == "Tags:" { $0 = "Tags:'"$readmeTags"'" } { printf "%s%s", $0, RS }' README.md)"
echo "$readme" > README.md

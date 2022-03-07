const { environment } = require('@rails/webpacker')
const webpack = require('webpack')
const dotenv = require('dotenv')

const dotenvFiles = [
    '.env'
]
dotenvFiles.forEach((dotenvFile) => {
    dotenv.config({path: dotenvFile, silent: true})
})

environment.plugins.prepend('Environment',
    new webpack.EnvironmentPlugin(
        JSON.parse(JSON.stringify(process.env))
    )
)

environment.plugins.prepend('Provide',
    new webpack.ProvidePlugin({
        $: 'jquery/src/jquery',
        jQuery: 'jquery/src/jquery',
        Popper: 'popper.js'
    })
)

module.exports = environment

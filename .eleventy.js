const { DateTime } = require("luxon");

const markdownIt = require("markdown-it");
const markdownItAnchor = require("markdown-it-anchor");
const markdownItFootnote = require("markdown-it-footnote");

const { EleventyHtmlBasePlugin } = require("@11ty/eleventy");

const pluginRss = require("@11ty/eleventy-plugin-rss");
const pluginNavigation = require("@11ty/eleventy-navigation");

const syntaxHighlight = require("@11ty/eleventy-plugin-syntaxhighlight");
const codeClipboard = require("eleventy-plugin-code-clipboard");

module.exports = function (eleventyConfig) {
  eleventyConfig.addWatchTarget("assets/**/*.{svg,webp,png,jpeg}");
  eleventyConfig.addWatchTarget("_layouts/**/*");
  eleventyConfig.addWatchTarget("_includes/**/*");

  eleventyConfig.addPlugin(EleventyHtmlBasePlugin);
  eleventyConfig.addPlugin(pluginRss);

  eleventyConfig.addPlugin(syntaxHighlight);
  eleventyConfig.addPlugin(codeClipboard);

  eleventyConfig.addPassthroughCopy({ assets: "/" });

  eleventyConfig.addPlugin(pluginNavigation);

  const markdownLib = markdownIt({ html: true, typographer: true }).use(
    codeClipboard.markdownItCopyButton,
    {
      iconifyUrl: "/images/content-copy.svg",
    }
  );
  markdownLib.use(markdownItFootnote).use(markdownItAnchor);
  eleventyConfig.setLibrary("md", markdownLib);

  eleventyConfig.setFrontMatterParsingOptions({
    excerpt: true,
    excerpt_separator: "<!-- more -->",
    excerpt_alias: "feed_excerpt",
  });

  eleventyConfig.addWatchTarget("./_site/output.css");

  eleventyConfig.addShortcode("version", function () {
    return String(Date.now());
  });

  eleventyConfig.addFilter("htmlDateString", (dateObj) => {
    return DateTime.fromJSDate(dateObj).toFormat("MMMM d, yyyy");
  });

  eleventyConfig.addFilter("asPostDate", (dateObj) => {
    var newFormat = { ...DateTime.DATETIME_HUGE, timeZoneName: "short" };
    return DateTime.fromJSDate(dateObj).toLocaleString(newFormat);
  });

  eleventyConfig.addFilter("getAllTags", (collection) => {
    let tagSet = new Set();
    for (let item of collection) {
      (item.data.tags || []).forEach((tag) => tagSet.add(tag));
    }
    return Array.from(tagSet);
  });

  eleventyConfig.addFilter("filterTagList", function filterTagList(tags) {
    return (tags || []).filter(
      (tag) => ["all", "nav", "post", "posts"].indexOf(tag) === -1
    );
  });

  // create a collection of posts with categories
  eleventyConfig.addCollection("postsByCategory", function (collection) {
    let postsByCategory = {};
    collection.getAllSorted().forEach(function (item) {
      if ("categories" in item.data && Array.isArray(item.data.categories)) {
        item.data.categories.forEach(function (category) {
          if (postsByCategory[category] === undefined) {
            postsByCategory[category] = [];
          }
          postsByCategory[category].push(item);
        });
      }
    });
    return postsByCategory;
  });

  eleventyConfig.addFilter(
    "filterCategoryList",
    function filterCategoryList(categories) {
      return (categories || []).filter(
        (category) => ["all", "nav", "post", "posts"].indexOf(category) === -1
      );
    }
  );

  // create a filter to count the number of posts by category
  eleventyConfig.addFilter("categoryCount", function (category) {
    let postsByCategory = this.getCollection("postsByCategory");
    if (!postsByCategory[category]) {
      return 0;
    }
    return postsByCategory[category].length;
  });

  return {
    templateFormats: ["md", "njk", "html", "liquid"],

    // Pre-process *.md files with: (default: `liquid`)
    markdownTemplateEngine: "liquid",

    // Pre-process *.html files with: (default: `liquid`)
    htmlTemplateEngine: "liquid",

    dir: {
      input: "./",
      output: "./_site",
      layouts: "_layouts",
    },
    pathPrefix: "/",
  };
};

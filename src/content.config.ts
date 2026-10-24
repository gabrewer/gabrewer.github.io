import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

// Flexible tags: string or array of strings (11ty posts used both formats)
const tagsSchema = z.union([
  z.string().transform((s) => [s]),
  z.array(z.string()),
]).optional();

// Flexible categories: string or array of strings
const categoriesSchema = z.union([
  z.string().transform((s) => [s]),
  z.array(z.string()),
]).optional();

const blogSchema = z.object({
  title: z.string(),
  date: z.coerce.date(),
  draft: z.boolean().optional(),
  author: z.string().optional(),
  comments: z.boolean().default(true),
  categories: categoriesSchema,
  tags: tagsSchema,
  description: z.string().optional(),
  permalink: z.string().optional(),
  slug: z.string().optional(),
});

const blog = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/blog' }),
  schema: blogSchema,
});

const links = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/links' }),
  schema: blogSchema,
});

export const collections = { blog, links };

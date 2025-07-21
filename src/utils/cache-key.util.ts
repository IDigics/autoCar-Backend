export function buildCacheKey(
  filters: Record<string, any> = {},
  ...parts: string[]
): string {
  // 1. Filter out undefined or null values, then sort keys alphabetically for consistency
  const entries = Object.entries(filters)
    .filter(([_, value]) => value !== undefined && value !== null)
    .sort(([keyA], [keyB]) => keyA.localeCompare(keyB));

  // 2. Serialize each filter as "key:value", handling objects with JSON.stringify
  const filterString = entries
    .map(([key, value]) => {
      const k = String(key).trim();
      let valueStr: string;

      if (typeof value === 'object' && value !== null) {
        try {
          valueStr = JSON.stringify(value);
        } catch {
          valueStr = String(value);
        }
      } else {
        valueStr = String(value).trim();
      }

      return `${k}:${valueStr}`;
    })
    .join(',');

  // 3. Use 'filters:none' if no filters present to keep key format consistent
  const filtersPart = filterString.length > 0 ? `filters:${filterString}` : 'filters:none';

  // 4. Join all parts with '::' to form the final cache key
  return ['cars', filtersPart, ...parts].join('::');
}

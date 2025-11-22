"use client";

import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
} from "recharts";

const data = [
  { name: "Sales", count: 70 },
  { name: "Engineering", count: 90 },
  { name: "Marketing", count: 50 },
  { name: "Design", count: 60 },
  { name: "HR", count: 30 },
  { name: "Support", count: 40 },
];

export function HeadcountChart() {
  return (
    <div className="h-64 w-full">
      <ResponsiveContainer width="100%" height="100%">
        <BarChart
          data={data}
          margin={{
            top: 10,
            right: 10,
            left: -20,
            bottom: 0,
          }}
        >
          <CartesianGrid
            strokeDasharray="3 3"
            vertical={false}
            stroke="currentColor"
            className="text-border-light dark:text-border-dark opacity-50"
          />
          <XAxis
            dataKey="name"
            tickLine={false}
            axisLine={false}
            tick={{ fontSize: 12, fill: "currentColor" }}
            className="text-text-secondary-light dark:text-text-secondary-dark"
            dy={10}
          />
          <YAxis
            tickLine={false}
            axisLine={false}
            tick={{ fontSize: 12, fill: "currentColor" }}
            className="text-text-secondary-light dark:text-text-secondary-dark"
          />
          <Tooltip
            cursor={{ fill: "transparent" }}
            contentStyle={{
              backgroundColor: "var(--color-card-light)",
              borderColor: "var(--color-border-light)",
              borderRadius: "0.5rem",
              color: "var(--color-text-primary-light)",
            }}
            itemStyle={{ color: "var(--color-primary)" }}
          />
          <Bar
            dataKey="count"
            fill="var(--color-primary)"
            radius={[4, 4, 0, 0]}
            barSize={40}
          />
        </BarChart>
      </ResponsiveContainer>
    </div>
  );
}


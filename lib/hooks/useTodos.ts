import { useState, useEffect } from 'react'
import { supabase } from '../supabase'

export interface Task {
  id: string
  text: string
  completed: boolean
  created_at: string
}

export function useTodos() {
  const [tasks, setTasks] = useState<Task[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  // 获取所有任务
  const fetchTasks = async () => {
    try {
      setLoading(true)
      const { data, error } = await supabase
        .from('todos')
        .select('*')
        .order('created_at', { ascending: false })

      if (error) {
        throw error
      }

      setTasks(data || [])
    } catch (err) {
      setError(err instanceof Error ? err.message : '获取任务失败')
    } finally {
      setLoading(false)
    }
  }

  // 添加任务
  const addTask = async (text: string) => {
    try {
      const { data, error } = await supabase
        .from('todos')
        .insert([{ text, completed: false }])
        .select()

      if (error) {
        throw error
      }

      if (data) {
        setTasks([data[0], ...tasks])
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : '添加任务失败')
    }
  }

  // 切换任务状态
  const toggleTask = async (id: string) => {
    try {
      const task = tasks.find(t => t.id === id)
      if (!task) return

      const { error } = await supabase
        .from('todos')
        .update({ completed: !task.completed })
        .eq('id', id)

      if (error) {
        throw error
      }

      setTasks(tasks.map(task => 
        task.id === id ? { ...task, completed: !task.completed } : task
      ))
    } catch (err) {
      setError(err instanceof Error ? err.message : '更新任务失败')
    }
  }

  // 删除任务
  const deleteTask = async (id: string) => {
    try {
      const { error } = await supabase
        .from('todos')
        .delete()
        .eq('id', id)

      if (error) {
        throw error
      }

      setTasks(tasks.filter(task => task.id !== id))
    } catch (err) {
      setError(err instanceof Error ? err.message : '删除任务失败')
    }
  }

  // 初始化时获取任务
  useEffect(() => {
    fetchTasks()
  }, [])

  return {
    tasks,
    loading,
    error,
    addTask,
    toggleTask,
    deleteTask,
    refetch: fetchTasks
  }
}

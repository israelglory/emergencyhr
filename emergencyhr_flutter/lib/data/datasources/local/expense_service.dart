import 'package:emergencyhr_flutter/data/datasources/local/expense_local_storage.dart';
import 'package:emergencyhr_flutter/data/model/params/expense.dart';

class ExpenseService {
  final ExpenseLocalStorage _localStorage = ExpenseLocalStorage();

  Future<void> saveExpense(Expense expense) async {
    try {
      final expenses = await getAllExpenses();
      expenses.insert(0, expense); // Insert newest first
      _localStorage.saveExpenses(expenses);
    } catch (e) {
      throw Exception('Failed to save expense: $e');
    }
  }

  Future<List<Expense>> getAllExpenses() async {
    try {
      final expenses = _localStorage.getExpenses();
      expenses.sort((a, b) => b.date.compareTo(a.date));
      return expenses;
    } catch (e) {
      return [];
    }
  }

  Future<Expense?> getExpenseById(String id) async {
    try {
      final expenses = await getAllExpenses();
      return expenses.firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteExpense(String id) async {
    try {
      final expenses = await getAllExpenses();
      expenses.removeWhere((e) => e.id == id);
      _localStorage.saveExpenses(expenses);
    } catch (e) {
      throw Exception('Failed to delete expense: $e');
    }
  }

  Future<void> updateExpense(Expense updatedExpense) async {
    try {
      final expenses = await getAllExpenses();
      final index = expenses.indexWhere((e) => e.id == updatedExpense.id);

      if (index != -1) {
        expenses[index] = updatedExpense;
        _localStorage.saveExpenses(expenses);
      } else {
        throw Exception('Expense not found');
      }
    } catch (e) {
      throw Exception('Failed to update expense: $e');
    }
  }

  Future<List<Expense>> searchExpenses(String query) async {
    try {
      final expenses = await getAllExpenses();
      final lowerQuery = query.toLowerCase();

      return expenses.where((e) {
        return e.title.toLowerCase().contains(lowerQuery) ||
            e.category.toLowerCase().contains(lowerQuery) ||
            (e.note != null && e.note!.toLowerCase().contains(lowerQuery));
      }).toList();
    } catch (e) {
      return [];
    }
  }
}
